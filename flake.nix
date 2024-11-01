{
  description = "gradient ascent";

  nixConfig = {
    allow-import-from-derivation = "true";
    bash-prompt = "[hakyll-nix]λ ";
    extra-substituters = [
      "https://cache.iog.io"
    ];
    extra-trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };

  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      haskellNix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        hls = pkgs.haskell-language-server;
        overlays = [
          haskellNix.overlay
          (final: prev: {
            hakyllProject = final.haskell-nix.project' {
              src = ./ssg;
              compiler-nix-name = "ghc948";
              modules = [ { doHaddock = false; } ];
              shell.buildInputs = [
                hakyll-site
                hls
                nodejs
                pkgs.nodePackages.rollup
                pkgs.nodePackages.npm
                pkgs.node2nix
              ];
              shell.tools = {
                cabal = "latest";
                hlint = "latest";
                haskell-language-server = "latest";
              };
            };
          })
        ];

        pkgs = import nixpkgs {
          inherit overlays system;
          inherit (haskellNix) config;
        };

        nodejs = pkgs.nodejs;

        nodeDeps = (pkgs.callPackage ./nix { inherit pkgs nodejs system; }).nodeDependencies;

        flake = pkgs.hakyllProject.flake { };

        executable = "ssg:exe:hakyll-site";

        hakyll-site = flake.packages.${executable};

        website = pkgs.stdenv.mkDerivation {
          name = "website";
          buildInputs = [
            nodejs
            pkgs.nodePackages.rollup
          ];
          src = pkgs.nix-gitignore.gitignoreSourcePure [
            ./.gitignore
            ".git"
            ".github"
          ] ./.;

          # LANG and LOCALE_ARCHIVE are fixes pulled from the community:
          #   https://github.com/jaspervdj/hakyll/issues/614#issuecomment-411520691
          #   https://github.com/NixOS/nix/issues/318#issuecomment-52986702
          #   https://github.com/MaxDaten/brutal-recipes/blob/source/default.nix#L24
          LANG = "en_US.UTF-8";
          LOCALE_ARCHIVE = pkgs.lib.optionalString (
            pkgs.buildPlatform.libc == "glibc"
          ) "${pkgs.glibcLocales}/lib/locale/locale-archive";

          buildPhase = ''
            ${flake.packages.${executable}}/bin/hakyll-site build --verbose
            ln -s ${nodeDeps}/lib/node_modules ./node_modules

            export PATH="${nodeDeps}/bin:$PATH"
            rollup -c
          '';

          installPhase = ''
            mkdir -p "$out/dist"
            cp -a dist/. "$out/dist"
          '';
        };

      in
      flake
      // {
        apps = {
          default = flake-utils.lib.mkApp {
            drv = hakyll-site;
            exePath = "/bin/hakyll-site";
          };
        };

        packages = {
          inherit hakyll-site website nodeDeps;
          default = website;
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}

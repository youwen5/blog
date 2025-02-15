{
  description = "the involution";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        nodejs = pkgs.nodejs;

        hakyll-site = pkgs.haskellPackages.callCabal2nix "hakyll-site" ./ssg { };

        nodeDeps = pkgs.importNpmLock.buildNodeModules {
          inherit nodejs;
          npmRoot = ./.;
        };

        website = pkgs.stdenv.mkDerivation {
          pname = "website";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.nodePackages.npm ];

          # LANG and LOCALE_ARCHIVE are fixes pulled from the community:
          #   https://github.com/jaspervdj/hakyll/issues/614#issuecomment-411520691
          #   https://github.com/NixOS/nix/issues/318#issuecomment-52986702
          #   https://github.com/MaxDaten/brutal-recipes/blob/source/default.nix#L24
          LANG = "en_US.UTF-8";
          LOCALE_ARCHIVE = pkgs.lib.optionalString (
            pkgs.buildPlatform.libc == "glibc"
          ) "${pkgs.glibcLocales}/lib/locale/locale-archive";

          buildPhase = ''
            ln -s ${nodeDeps}/node_modules node_modules
            ${self.packages.${system}.hakyll-site}/bin/hakyll-site build

            npm run build
          '';

          installPhase = ''
            mkdir -p "$out/dist"
            cp -a dist/. "$out/dist"
          '';
        };

      in
      {
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

        devShells.default = pkgs.haskellPackages.shellFor {
          packages = hsPkgs: [
            hsPkgs.distribution-nixpkgs
            self.packages.${system}.hakyll-site
          ];

          npmDeps = nodeDeps;

          withHoogle = true;

          nativeBuildInputs = with pkgs; [
            cabal-install
            haskellPackages.cabal-gild
            haskellPackages.haskell-language-server
            pkgs.importNpmLock.hooks.linkNodeModulesHook
            nodejs
            pkgs.nodePackages.npm
          ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}

{
  description = "conditional finality";

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

        nodeDeps = (pkgs.callPackage ./nix { inherit pkgs nodejs system; }).nodeDependencies;

        hakyll-site = pkgs.haskellPackages.callCabal2nix "hakyll-site" ./ssg { };

        website = pkgs.stdenv.mkDerivation {
          name = "website";
          nativeBuildInputs = [
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
            # remove the node_modules symlink
            rm -rf node_modules

            ${self.packages.${system}.hakyll-site}/bin/hakyll-site build
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

          withHoogle = true;

          nativeBuildInputs = with pkgs; [
            cabal-install
            haskellPackages.cabal-gild
            haskellPackages.haskell-language-server
          ];
        };

        formatter = pkgs.nixfmt-rfc-style;
      }
    );
}

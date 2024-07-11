{
  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        helpers = pkgs.callPackages (import ./helpers.nix) { };
        npmlock2nix' = pkgs.fetchFromGitHub {
          owner = "nix-community";
          repo = "npmlock2nix";
          rev = "9197bbf397d76059a76310523d45df10d2e4ca81";
          hash = "sha256-sJM82Sj8yfQYs9axEmGZ9Evzdv/kDcI9sddqJ45frrU=";
        };
        npmlock2nix = pkgs.callPackages npmlock2nix' { inherit pkgs; };
        origLock = pkgs.lib.importJSON ./package-lock.json;
        filteredLock = builtins.toFile "package-lock.json"
          (builtins.toJSON (helpers.removeLinkedPackages origLock));
      in with pkgs; {

        packages.default = npmlock2nix.v2.node_modules {
          src = ./.;
          packageLockJson = filteredLock;
          nodejs = nodejs_22;
        };
        # packages.default = buildNpmPackage {
        #   name = "app";
        #   src = helpers.removeGitignored { root = ./.; };
        #   npmDeps = importNpmLock { npmRoot = ./.; };
        #   npmConfigHook = importNpmLock.npmConfigHook;
        # };
      });
}

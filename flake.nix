{
  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        remove-gitignored =
          pkgs.callPackage (import ./remove-gitignored.nix) { };
      in with pkgs; {
        packages.default = buildNpmPackage {
          name = "app";
          src = remove-gitignored { root = ./.; };
          npmDeps = importNpmLock { npmRoot = ./.; };
          npmConfigHook = importNpmLock.npmConfigHook;
        };
      });
}

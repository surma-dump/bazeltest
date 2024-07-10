{
  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils, rust-js-wrapper }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        gitignore = pkgs.lib.readFile ./.gitignore;
      in with pkgs; {
        packages.default = buildNpmPackage {
          name = "app";
          src = lib.cleanSourceWith {
            src = ./.;
            filter = nix-gitignore.gitignoreFilter gitignore "${./.}";
          };
          npmDeps = importNpmLock { npmRoot = ./.; };
          npmConfigHook = importNpmLock.npmConfigHook;
        };
      });
}

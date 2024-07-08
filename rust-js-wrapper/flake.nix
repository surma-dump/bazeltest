{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    wasm-module.url = "path:../rust";
  };

  outputs = { self, nixpkgs, flake-utils, wasm-module }:
    let
      project = {
        name = "rust-js-wrapper";
        srcs = nixpkgs.lib.cleanSource ./.;
        npmDepsHash = "sha256-tsdjASgej7CG+9+v4zyK26POJCMyMt96sFS7iPTEu1c=";
      };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in {
        packages.default = pkgs.buildNpmPackage (project // {
          buildInputs = [ wasm-module.packages.${system}.default ];
        });
      });
}

{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    wasm-module.url = "path:../rust";
  };

  outputs = { self, nixpkgs, flake-utils, wasm-module }:
    let
      name = "rust-js-wrapper";
      project = {
        inherit name;
        srcs = ./..;
        npmDepsHash = "sha256-6lkXLj5+z7mZwtgbit/fzQ+LDsRXnj787yY8wjWNrxI=";
        npmWorkspace = name;
      };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in {
        packages.default = pkgs.buildNpmPackage (project // {
          buildInputs = [ wasm-module.packages.${system}.default ];
          npmBuildFlags = [ wasm-module.packages.${system}.default ];
        });
      });
}

{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    rust-js-wrapper.url = "path:./rust-js-wrapper";
  };

  outputs = { self, nixpkgs, flake-utils, rust-js-wrapper }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        systemProject = {

          name = "app";
          srcs = nixpkgs.lib.cleanSource ./.;
          npmDepsHash = "sha256-1iilvUGUzfy9QzjzXa1rIoKY+wtbF21y1VgIS/8Xu8M=";
          buildInputs = [ rust-js-wrapper.packages.${system}.default ];
        };
      in {

        packages.default = pkgs.buildNpmPackage systemProject;
      });
}

{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    rust-js-wrapper.url = "path:./rust-js-wrapper";
  };

  outputs = { self, nixpkgs, flake-utils, rust-js-wrapper }:
    let
      project = {
        name = "app";
        srcs = nixpkgs.lib.cleanSource ./.;
        npmDepsHash = "sha256-6lkXLj5+z7mZwtgbit/fzQ+LDsRXnj787yY8wjWNrxI=";
      };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in {
        packages.default = pkgs.buildNpmPackage (project // {
          nativeBuildInputs = [ rust-js-wrapper.packages.${system}.default ];
        });
        devShells.default = let dev-server = 0;
        in pkgs.mkShell { buildInputs = [ self.packages.${system}.default ]; };
      });
}

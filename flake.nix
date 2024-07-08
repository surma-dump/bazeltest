{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    wasm-module.url = "path:./rust";
  };

  outputs = { self, nixpkgs, flake-utils, wasm-module }:
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
        systemProject = project // {
          buildInputs = [ self.packages.${system}.rust-js-wrapper ];
        };
      in {
        packages.rust-js-wrapper = pkgs.buildNpmPackage (project // {
          npmWorkspace = "rust-js-wrapper";
          buildInputs = [ wasm-module.packages.${system}.default ];
          npmBuildFlags = [ wasm-module.packages.${system}.default ];
        });

        packages.default = pkgs.buildNpmPackage systemProject;

        devShells.default = let dev-server = 0;
        in pkgs.mkShell {
          buildInputs = systemProject.buildInputs;
          shellHook = "npm run dev";
        };
      });
}

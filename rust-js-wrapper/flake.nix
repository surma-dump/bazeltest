{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    wasm-module.url = "path:../rust";
  };

  outputs = { self, nixpkgs, flake-utils, wasm-module }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.buildNpmPackage {
          name = "rust-js-wrapper";
          srcs = ./.;
          npmDepsHash = "sha256-9UcGChPV7OtSSOTDsdcsruV+zVp27YaiSldCgQLdG5w=";
          buildInputs = [ wasm-module.packages.${system}.default ];
          npmBuildFlags = [ wasm-module.packages.${system}.default ];
          postPatch = ''
            cp ${./package-lock.json} package-lock.json
          '';
        };
      });
}

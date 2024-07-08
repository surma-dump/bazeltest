{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      project = {
        name = "app";
        srcs = nixpkgs.lib.cleanSource ./.;
        npmDepsHash = "sha256-tsdjASgej7CG+9+v4zyK26POJCMyMt96sFS7iPTEu1c=";
      };
    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in {
        packages.default = pkgs.buildNpmPackage project;
        devShells.default = let
          dev-server =
            pkgs.buildNpmPackage (project // { npmBuildScript = "dev"; });
        in pkgs.mkShell { buildInputs = [ dev-server ]; };
      });
}

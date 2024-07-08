{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages.default = let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in pkgs.buildNpmPackage {
        name = "app";
        srcs = lib.cleanSource ./.;
        npmDepsHash = "sha256-tsdjASgej7CG+9+v4zyK26POJCMyMt96sFS7iPTEu1c=";
      };
      devShells.default = let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
      in pkgs.mkShell {
        shellHook = ''
          cd js
          npm ci
          npm run dev
        '';
      };
    });
}

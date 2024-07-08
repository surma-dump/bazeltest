{
  description = "Example Rust flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, fenix, naersk, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages.default = let
        target = "wasm32-unknown-unknown";
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
        toolchain = with fenix.packages.${system};
          combine [
            stable.rustc
            stable.cargo
            targets.${target}.stable.rust-std
          ];
        naersk' = pkgs.callPackage naersk {
          rustc = toolchain;
          cargo = toolchain;
        };
      in naersk'.buildPackage {
        name = "lol";
        src = lib.cleanSource ./.;
        release = true;
        copyLibs = true;
        CARGO_BUILD_TARGET = target;
      };
    });
}

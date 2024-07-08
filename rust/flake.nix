{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    fenix.url = "github:nix-community/fenix";
    naersk.url = "github:nix-community/naersk";
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

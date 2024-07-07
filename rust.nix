{ 
  # pkgs ? import <nixpkgs> {},
  pkgs ? import /Users/surma/src/github.com/NixOS/nixpkgs {},
}:
let 
  target = "wasm32-unknown-unknown";
  # target = "wasm32-wasi";
  fenix = import ./fenix.nix {inherit pkgs;};
  naersk-lib = import ./naersk.nix {inherit pkgs;};
  toolchain =  fenix.combine [
    fenix.stable.rustc
    fenix.stable.cargo
    (builtins.getAttr target fenix.targets).stable.rust-std
  ];
  naersk = pkgs.callPackage naersk-lib {
    rustc = toolchain;
    cargo = toolchain;
  };
  rustPlatform = pkgs.makeRustPlatform {
    rustc = toolchain;
    cargo = toolchain;
    # stdenv = pkgs.pkgsCross.wasi32.stdenv;
  };
in 
# rustPlatform.buildRustPackage {
#   name = "lol";
#   cargoLock = {
#     lockFile = ./Cargo.lock;
#   };
#   auditable = false;
#   srcs = ./.;
# }
naersk.buildPackage {
  name = "lol";
  src = ./.;
  CARGO_BUILD_TARGET = target;
}

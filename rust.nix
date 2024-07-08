{ 
  pkgs ? import <nixpkgs> {},
  # pkgs ? import /Users/surma/src/github.com/NixOS/nixpkgs {},
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
  lib = pkgs.lib;
in 
naersk.buildPackage {
  name = "lol";
  src = lib.cleanSource ./.;
  release = true;
  copyLibs = true;
  CARGO_BUILD_TARGET = target;
}

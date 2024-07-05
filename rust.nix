{ 
  pkgs ? import <nixpkgs> {},
  # pkgs ? import /Users/surma/src/github.com/NixOS/nixpkgs {},
}:
let 
  fenix = import ./fenix.nix {inherit pkgs;};
  naersk-lib = import ./naersk.nix {inherit pkgs;};
  toolchain =  fenix.combine [
    fenix.stable.rustc
    fenix.stable.cargo
    fenix.targets.wasm32-wasi.stable.rust-std
  ];
  naersk = pkgs.callPackage naersk-lib {
    rustc = toolchain;
    cargo = toolchain;
  };
in 
naersk.buildPackage {
  name = "lol";
  src = ./.;
  CARGO_BUILD_TARGET = "wasm32-wasi";
}

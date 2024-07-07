{ 
  pkgs ? import <nixpkgs> {},
  # pkgs ? import /Users/surma/src/github.com/NixOS/nixpkgs {},
}:
let 
  # target = "wasm32-unknown-unknown";
  target = "wasm32-wasi";
  fenix = import ./fenix.nix {inherit pkgs;};
  toolchain =  fenix.combine [
    fenix.stable.rustc
    fenix.stable.cargo
    (builtins.getAttr target fenix.targets).stable.rust-std
  ];
  src = ./.;
in 
derivation {
  inherit src;
  name = "lol";
  system = builtins.currentSystem;
  builder = "${pkgs.bash}/bin/bash";
  args = ["-c" ''
    export PATH=$PATH:${pkgs.coreutils}/bin:${toolchain}/bin
    cp -r ${src}/. .
    cargo build -r --target ${target}
    mkdir -p $out/bin
    cp target/${target}/release/lol.wasm $out/bin
  ''];
}

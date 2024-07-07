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
in 
pkgs.stdenv.mkDerivation {
  name = "lol";
  src = ./.;
  buildInputs = [toolchain pkgs.jq];
  buildPhase = ''
    cargo build -r --target ${target} --message-format=json > log.json
  '';
  installPhase = ''
    mkdir -p $out/bin;
    FILE=$(cat log.json | jq -rs '.[0].executable')
    cp $FILE $out/bin
  '';
}

{ 
  # pkgs ? import <nixpkgs> {},
  pkgs ? import /Users/surma/src/github.com/NixOS/nixpkgs {},
}:
let 
  # rustPlatform = pkgs.pkgsCross.wasm32-unknown-none.rustPlatform;
  pkgs' = pkgs.pkgsCross.wasi32;
  fenixRepo = { 
    owner = "nix-community"; 
    repo = "fenix"; 
    rev = "f6994934e25396d3a70ddb908cefccd8d3c37ac4"; 
    hash="sha256-GPl5qug68zcCBvkakakTdzuA/LIOdWyJbAjXkoeM+FE=";
  };
  fenixFactory = import(pkgs.fetchFromGitHub fenixRepo);
  fenix = pkgs.callPackage fenixFactory {};
  crateToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
  rustPlatform = with fenix.targets.wasm32-unknown-unknown.stable; pkgs.makeRustPlatform {
    rustc = completeToolchain;
    # cargo = pkgs.cargo;
    cargo = completeToolchain;
  };
in 
rustPlatform.buildRustPackage {
  name = "lol";
  src = ./.;
  cargoLock = {
    lockFile = ./Cargo.lock;
  };
}

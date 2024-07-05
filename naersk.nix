{ 
  pkgs ? import <nixpkgs> {},
}:
let
  repo = { 
    owner = "nix-community"; 
    repo = "naersk"; 
    rev = "941ce6dc38762a7cfb90b5add223d584feed299b"; 
    hash = "sha256-uFsCwWYI2pUpt0awahSBorDUrUfBhaAiyz+BPTS2MHk=";
  };
  factory = import(pkgs.fetchFromGitHub repo);
in
factory

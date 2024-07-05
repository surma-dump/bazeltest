{ 
  pkgs ? import <nixpkgs> {},
}:
let
  repo = { 
    owner = "nix-community"; 
    repo = "fenix"; 
    rev = "f6994934e25396d3a70ddb908cefccd8d3c37ac4"; 
    hash = "sha256-GPl5qug68zcCBvkakakTdzuA/LIOdWyJbAjXkoeM+FE=";
  };
  factory = import(pkgs.fetchFromGitHub repo);
in
pkgs.callPackage factory {}

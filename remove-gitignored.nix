{ lib, nix-gitignore }:
{ root, gitignore ? "${root}/.gitignore", }:
let gitignore' = lib.readFile gitignore;
in lib.cleanSourceWith {
  src = root;
  filter = nix-gitignore.gitignoreFilter gitignore' "${root}";
}

{ lib, nix-gitignore }: rec {
  removeLinkedPackages = lock:
    let
      packageList = lib.attrsToList lock.packages;

      isLinkedPackage = p: p.value.link or false;
      isNodePackage = p: lib.strings.hasPrefix "node_modules" p.name;
      filteredPackageList =
        lib.filter (p: (isNodePackage p) && !(isLinkedPackage p)) packageList;
      filteredPackages = lib.listToAttrs filteredPackageList;
    in lock // { packages = filteredPackages; };

  removeGitignored = { root, gitignore ? "${root}/.gitignore", }:
    let gitignore' = lib.readFile gitignore;
    in lib.cleanSourceWith {
      src = root;
      filter = nix-gitignore.gitignoreFilter gitignore' "${root}";
    };
}

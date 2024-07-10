{ system ? builtins.currentSystem, pkgs ? (import <nixpkgs> { inherit system; })
, }:
with pkgs;
let
  lock = lib.importJSON ./package-lock.json;

  parseIntegrity = hash:
    if (lib.strings.hasPrefix "sha256-" hash) then {
      sha256 = hash;
    } else if (lib.strings.hasPrefix "sha512-" hash) then {
      sha512 = hash;
    } else
      lib.throw "Unsupported hash ${hash}";

  downloadPackageFromLock = lock: packageName:
    let
      package = lock.packages.${packageName};
      tarball = fetchurl
        ({ url = package.resolved; } // (parseIntegrity package.integrity));
    in stdenv.mkDerivation {
      name = packageName;
      inherit packageName;
      src = tarball;
      buildPhase = ''
        mkdir -p $out/lib/$packageName
        cd $out/lib/$packageName
        tar --strip-components 1 -xf $src
      '';
    };

  allPackages =
    lib.filter ({ name, ... }: lib.strings.hasPrefix "node_modules" name)
    (lib.attrsToList lock.packages);
  filteredPackages =
    lib.filter ({ value, ... }: lib.strings.hasPrefix "http" value.resolved)
    (lib.filter ({ value, ... }: lib.hasAttr "resolved" value) allPackages);

in stdenv.mkDerivation {
  name = "node_modules";
  srcs = lib.map ({ name, value }: downloadPackageFromLock lock name)
    filteredPackages;
  unpackPhase = "true";
  buildPhase = ''
    mkdir -p $out
    for dep in $srcs; do
      ${rsync}/bin/rsync -r $dep/lib/node_modules/* $out/
    done'';
}

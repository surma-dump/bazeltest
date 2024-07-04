let pkgs = import <nixpkgs> {}; in
derivation {
  name = "lol";
  system = builtins.currentSystem;
  builder = "/bin/sh";
  src = ./input.txt;
  args = ["-c" "(${pkgs.coreutils}/bin/cat $src; echo '!') > $out" ];
}


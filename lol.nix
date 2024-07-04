let pkgs = import <nixpkgs> {}; in
derivation {
  name = "lol";
  system = builtins.currentSystem;
  builder = "/bin/sh";
  srcs = [./input.txt ./input2.txt];
  args = ["-c" "(${pkgs.coreutils}/bin/cat $srcs; echo '!') > $out" ];
}


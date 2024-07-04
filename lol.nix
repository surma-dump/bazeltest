derivation {
  name = "lol";
  system = builtins.currentSystem;
  builder = "/bin/sh";
  args = ["-c" "echo lol > $out" ];
   
}

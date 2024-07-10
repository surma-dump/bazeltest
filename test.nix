with (import <nixpkgs> {});
let
  a = 1;
  # offlineCache = fetchYarnDeps { yarnLock = ./yarn.lock; hash = "sha256-AND1Gxm60LwGnNLqpfppgGzqo0Ctaafo9PKMHXiZtZ0=";};
in

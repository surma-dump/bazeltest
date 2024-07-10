{
  inputs = { 
    flake-utils.url = "github:numtide/flake-utils"; 
    # npmlock2nix.url = "github:nix-community/npmlock2nix";
  };

  outputs = { self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        npmlock2nix' = pkgs.fetchFromGitHub {
          owner = "nix-community";
          repo = "npmlock2nix";
          rev = "9197bbf397d76059a76310523d45df10d2e4ca81";
          hash = "sha256-sJM82Sj8yfQYs9axEmGZ9Evzdv/kDcI9sddqJ45frrU=";
        };
        npmlock2nix = pkgs.callPackages npmlock2nix' {inherit pkgs;};
        remove-gitignored =
          pkgs.callPackage (import ./remove-gitignored.nix) { };
      in with pkgs; {

        packages.default = npmlock2nix.v1.node_modules {
          src = ./.;
        };
        # packages.default = buildNpmPackage {
        #   name = "app";
        #   src = remove-gitignored { root = ./.; };
        #   npmDeps = importNpmLock { npmRoot = ./.; };
        #   npmConfigHook = importNpmLock.npmConfigHook;
        # };
      });
}

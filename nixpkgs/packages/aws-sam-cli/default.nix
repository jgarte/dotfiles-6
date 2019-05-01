let
  nixpkgs-source = builtins.fetchTarball {
    url = https://releases.nixos.org/nixos/19.03/nixos-19.03.172392.6d7ed964296/nixexprs.tar.xz;
  };
  nixpkgs = import nixpkgs-source {};
in
  nixpkgs.callPackage (import "${nixpkgs-source}/pkgs/development/tools/aws-sam-cli/default.nix") {}

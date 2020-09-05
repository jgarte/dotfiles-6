export NIXPKGS="https://releases.nixos.org/nixpkgs/nixpkgs-20.09pre242076.fd457ecb6cc/nixexprs.tar.xz"
export HOME_MANAGER="https://github.com/rycee/home-manager/archive/41b1af808f1de69c31f3fd164d5274154ee782e4.tar.gz"

set_nix_path () {
  local nixpkgs_path="nixpkgs=$NIXPKGS"
  local home_manager_path="home-manager=$HOME_MANAGER"

  export NIX_PATH=$nixpkgs_path:$home_manager_path
}

set_nix_path

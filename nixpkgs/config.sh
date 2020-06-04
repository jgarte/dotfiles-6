export NIXPKGS="https://releases.nixos.org/nixpkgs/nixpkgs-20.09pre228165.00df2371122/nixexprs.tar.xz"
export HOME_MANAGER="https://github.com/rycee/home-manager/archive/f487b527ec420b888c52df1c4f8c31439201edb7.tar.gz"

set_nix_path () {
  local nixpkgs_path="nixpkgs=$NIXPKGS"
  local home_manager_path="home-manager=$HOME_MANAGER"

  export NIX_PATH=$nixpkgs_path:$home_manager_path
}

set_nix_path

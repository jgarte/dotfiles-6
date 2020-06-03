export NIXPKGS="https://releases.nixos.org/nixos/unstable/nixos-20.03pre211190.a21c2fa3ea2/nixexprs.tar.xz"
export HOME_MANAGER="https://github.com/rycee/home-manager/archive/f487b527ec420b888c52df1c4f8c31439201edb7.tar.gz"

set_nix_path () {
  local nixpkgs_path="nixpkgs=$NIXPKGS"
  local home_manager_path="home-manager=$HOME_MANAGER"

  export NIX_PATH=$nixpkgs_path:$home_manager_path
}

set_nix_path

export NIXPKGS="https://releases.nixos.org/nixpkgs/nixpkgs-20.09pre235652.7d557a5d1b3/nixexprs.tar.xz"
export HOME_MANAGER="https://github.com/rycee/home-manager/archive/7b73f840712de88093f6c056e3c658e114ca0b3c.tar.gz"

set_nix_path () {
  local nixpkgs_path="nixpkgs=$NIXPKGS"
  local home_manager_path="home-manager=$HOME_MANAGER"

  export NIX_PATH=$nixpkgs_path:$home_manager_path
}

set_nix_path

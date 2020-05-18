set_nix_path () {
  local nixpkgs="https://releases.nixos.org/nixos/unstable/nixos-20.03pre211190.a21c2fa3ea2/nixexprs.tar.xz"
  local nixpkgs_path="nixpkgs=$nixpkgs"
  local home_manager="https://github.com/rycee/home-manager/archive/f487b527ec420b888c52df1c4f8c31439201edb7.tar.gz"
  local home_manager_path="home-manager=$home_manager"

  export NIX_PATH=$nixpkgs_path:$home_manager_path
}

source_nix_env () {
  local nix_profile_env="/nix/var/nix/profiles/default/etc/profile.d/nix.sh"

  if [ -f $nix_profile_env ]; then
    . $nix_profile_env
  fi
}

init_nix () {
  set_nix_path
  source_nix_env
}

init_nix

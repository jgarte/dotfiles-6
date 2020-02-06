nixpkgs="https://releases.nixos.org/nixos/unstable/nixos-20.03pre211190.a21c2fa3ea2/nixexprs.tar.xz"
home_manager="https://github.com/rycee/home-manager/archive/7ec153889c05a840e372c04bca420298e5403dff.tar.gz"

export NIX_PATH="nixpkgs=$nixpkgs:home-manager=$home_manager"
export PATH="$HOME/.nix-profile/bin:$PATH"

profile_env="$HOME/.nix-profile/etc/profile.d/nix.sh"

if [ -f $profile_env ]; then
  . $profile_env
fi

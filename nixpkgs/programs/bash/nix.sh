export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export PATH="$HOME/.nix-profile/bin:$PATH"

. $HOME/.nix-profile/etc/profile.d/nix.sh

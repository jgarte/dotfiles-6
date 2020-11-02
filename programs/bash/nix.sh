source_nix_env () {
  local nix_profile_env="/nix/var/nix/profiles/default/etc/profile.d/nix.sh"

  if [ -f $nix_profile_env ]; then
    . $nix_profile_env
  fi
}

source_nix_env

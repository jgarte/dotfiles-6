# Dotfiles

Keeping it simple

## Setup

#### [Nix](https://nixos.org/nix/)

```
$ curl https://nixos.org/nix/install | sh
$ nix-channel --add https://nixos.org/channels/nixos-19.03 nixpkgs
$ nix-channel --update
```

#### [Home Manager](https://github.com/rycee/home-manager)

```
$ nix-channel --add https://github.com/rycee/home-manager/archive/release-19.03.tar.gz home-manager
$ nix-channel --update
$ NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH nix-shell '<home-manager>' -A install
$ ln -sfT ~/.dotfiles/nixpkgs ~/.config/nixpkgs
$ home-manager switch
```

#### [Bash](https://www.gnu.org/software/bash/)

Set the Nix-installed Bash as the one for your user.

```
$ sudo bash -c "echo $(which bash) >> /etc/shells"
$ chsh -s $(which bash) $(whoami)
```

You'll need to log out then in again for this to take effect.

#### [Base16 Shell](https://github.com/chriskempson/base16-shell)

Set the color scheme.

```
$ base16_tomorrow
```

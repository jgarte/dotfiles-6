# Dotfiles

Keeping it simple

## Setup

#### [Nix](https://nixos.org/nix/)

```
$ curl https://nixos.org/nix/install | sh
```

#### [Home Manager](https://github.com/rycee/home-manager)

*TODO* Script this

```
$ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH nix-shell '<home-manager>' -A install
$ cp -rf ~/.dotfiles/nix/* ~/.config/nixpkgs/
$ home-manager switch
```

#### [Base16 Shell](https://github.com/chriskempson/base16-shell)

Set the color scheme.

```
$ base16_tomorrow
```

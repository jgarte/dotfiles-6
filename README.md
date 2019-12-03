# Dotfiles

Keeping it simple

## Setup

#### 1. [Nix](https://nixos.org/nix/)

```
$ curl https://nixos.org/nix/install | sh
$ source ~/.dotfiles/nixpkgs/programs/bash/nix.sh
```

#### 2. [Home Manager](https://github.com/rycee/home-manager)

```
$ ln -sfT ~/.dotfiles/nixpkgs ~/.config/nixpkgs
$ nix-shell '<home-manager>' -A install
```

#### 3. [Bash](https://www.gnu.org/software/bash/)

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

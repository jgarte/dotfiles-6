# Dotfiles

Keeping it simple

## Setup

#### [Fresh](https://freshshell.com/)

```
$ bash -c "`curl -sL https://get.freshshell.com`"
```

Fresh should now be good to go.

#### [Nix](https://nixos.org/nix/)

```
$ curl https://nixos.org/nix/install | sh
```

You can now install all the [things](nix/config.nix) I find useful.

```
$ nix-env -i all
```

#### [Base16 Shell](https://github.com/chriskempson/base16-shell)

Set the color scheme.

```
$ base16_tomorrow
```

#### [Tmux](https://github.com/tmux/tmux/wiki)

```
$ tmux
```

Type `<C-a> I` (that's `Control` + `a` then `I`) to install plugins.

#### [Vim](https://www.vim.org/)

Install all the plugins.

```
$ vim +'PlugInstall | qa'
```

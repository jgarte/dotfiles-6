{ pkgs, config, ... }:
{
  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
    ];
    extraConfig = builtins.readFile ./programs/tmux/tmux.conf;
  };

  programs.vim = {
    enable = true;
    plugins = [
      "ale"
      "base16-vim"
      "editorconfig-vim"
      "fzf-vim"
      "fzfWrapper"
      "nerdtree"
      "vim-abolish"
      "vim-airline"
      "vim-airline-themes"
      "vim-commentary"
      "vim-gitgutter"
      "vim-multiple-cursors"
      "vim-polyglot"
      "vim-sensible"
      "vim-surround"
      "vim-trailing-whitespace"
    ];
    extraConfig = builtins.readFile ./programs/vim/vimrc;
  };

  home.file.".gitignore".text = builtins.readFile ./programs/git/gitignore;
  home.file.".gitconfig".text = builtins.readFile ./programs/git/gitconfig;

  home.file.".config/base16-shell" = {
    source = builtins.fetchTarball "https://github.com/chriskempson/base16-shell/archive/master.tar.gz";
  };

  home.file.".local/share/git-completion.bash" = {
    source = "${builtins.fetchTarball "https://github.com/git/git/archive/master.tar.gz"}/contrib/completion/git-completion.bash";
  };

  home.file.".config/termonad/termonad.hs".text = builtins.readFile ./programs/termonad/termonad.hs;

  home.file.".bashrc".text = "
    ${builtins.readFile ./programs/bash/base-16.sh}
    ${builtins.readFile ./programs/bash/clipboard.sh}
    ${builtins.readFile ./programs/bash/codecdpath.sh}
    ${builtins.readFile ./programs/bash/completion.sh}
    ${builtins.readFile ./programs/bash/direnv.sh}
    ${builtins.readFile ./programs/bash/docker-compose.sh}
    ${builtins.readFile ./programs/bash/editor.sh}
    ${builtins.readFile ./programs/bash/fuzzy-cd.sh}
    ${builtins.readFile ./programs/bash/git.sh}
    ${builtins.readFile ./programs/bash/history.sh}
    ${builtins.readFile ./programs/bash/ls.sh}
    ${builtins.readFile ./programs/bash/nix-shell.sh}
    ${builtins.readFile ./programs/bash/nix.sh}
    ${builtins.readFile ./programs/bash/opts.sh}
    ${builtins.readFile ./programs/bash/path.sh}
    ${builtins.readFile ./programs/bash/prompt.sh}
    ${builtins.readFile ./programs/bash/reload.sh}
    ${builtins.readFile ./programs/bash/rust.sh}
    ${builtins.readFile ./programs/bash/title.sh}
  ";

  home.packages = with pkgs; [
    asciinema
    bash-completion
    bashInteractive
    cabal-install
    cabal2nix
    coreutils
    darcs
    direnv
    entr
    fd
    fzf
    ghc
    git
    gnupg1
    haskellPackages.ghcid
    haskellPackages.hindent
    hlint
    htop
    jq
    ncdu
    powerline-fonts
    ripgrep
    tree
  ];
}

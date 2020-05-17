{ pkgs, lib, config, ... }:
let
  vim-with-packages = (pkgs.vim_configurable.overrideAttrs (attrs: {
    configureFlags =
      lib.filter
        (f: !(lib.hasPrefix "--enable-gui" f))
        attrs.configureFlags;
  })).customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./programs/vim/vimrc;
    vimrcConfig.packages.default = with pkgs.vimPlugins; {
      start = [
        ale
        base16-vim
        editorconfig-vim
        fzf-vim
        fzfWrapper
        nerdtree
        vim-abolish
        vim-airline
        vim-airline-themes
        vim-better-whitespace
        vim-commentary
        vim-gitgutter
        vim-grammarous
        vim-multiple-cursors
        vim-polyglot
        vim-sensible
        vim-surround
      ];
    };
  };
in
rec {
  imports = [
    ./programs/alacritty/module.nix
    ./programs/termonad/module.nix
    ./modules/powerline-fonts.nix
  ];

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/f487b527ec420b888c52df1c4f8c31439201edb7.tar.gz;
  };

  programs.tmux = {
    enable = true;
    escapeTime = 0;
    extraConfig = builtins.readFile ./programs/tmux/tmux.conf;
    newSession = true;
    package = pkgs.tmux;
    plugins = with pkgs.tmuxPlugins; [ yank ];
    terminal = "screen-256color";
  };

  programs.cross-platform-alacritty = {
    enable = builtins.currentSystem == "x86_64-darwin";
    settings = {
      shell = {
        program = "${programs.tmux.package}/bin/tmux";
        args = [ "attach" ];
      };
      font = {
        size = 18;
        normal = {
          family = "Roboto Mono for Powerline";
          style = "Regular";
        };
        bold = {
          family = "Roboto Mono for Powerline";
          style = "Bold";
        };
        italic = {
          family = "Roboto Mono for Powerline";
          style = "Italic";
        };
      };
    };
  };

  programs.termonad = {
    enable = builtins.currentSystem != "x86_64-darwin";
    configuration = builtins.readFile ./programs/termonad/termonad.hs;
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

  home.file.".bashrc".text = ''
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
    ${builtins.readFile ./programs/bash/pager.sh}
    ${builtins.readFile ./programs/bash/path.sh}
    ${builtins.readFile ./programs/bash/prompt.sh}
    ${builtins.readFile ./programs/bash/reload.sh}
    ${builtins.readFile ./programs/bash/rust.sh}
    ${builtins.readFile ./programs/bash/title.sh}
  '';

  home.packages = with pkgs; [
    asciinema
    awscli
    bash-completion
    bashInteractive
    cabal-install
    cabal2nix
    coreutils
    direnv
    entr
    fd
    fzf
    ghc
    git
    gnupg1
    haskellPackages.ghcid
    haskellPackages.ormolu
    hlint
    htop
    ipcalc
    jq
    libossp_uuid
    lynx
    ncdu
    netcat
    nmap
    ripgrep
    tree
    tshark
    vim-with-packages
  ] ++ lib.optionals (builtins.currentSystem != "x86_64-darwin") [
    xclip
    xsel
  ];
}

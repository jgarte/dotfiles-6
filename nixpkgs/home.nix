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
    path = builtins.getEnv "HOME_MANAGER";
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
        size = 24;
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

  powerline-fonts.enable = true;

  programs.autorandr = {
    enable = builtins.currentSystem != "x86_64-darwin";

    profiles = {
      "aoc" = {
        fingerprint = {
          HDMI-1 = "00ffffffffffff0005e390273f0801001e1d0103803c22782a67a1a5554da2270e5054bfef00d1c0b30095008180814081c001010101a36600a0f0701f803020350055502100001a565e00a0a0a029503020350055502100001e000000fc005532373930420a202020202020000000fd0017501e631e000a2020202020200188020326f14b101f05140413031202110123090707830100006d030c002000383c200060010203023a801871382d40582c450055502100001e011d007251d01e206e28550055502100001e8c0ad08a20e02d10103e96005550210000184d6c80a070703e8030203a0055502100001a000000000000000000000000000000000098";
          eDP-1 = "00ffffffffffff00387000000000000000190104a51d117806de50a3544c99260f5054000000010101010101010101010101010101011a3680a070381f403020350026a510000018542b80a070381f403020350026a510000018000000100000000000000000000000000000000000fc004c433133334c46324c30310a200022";
        };
        config = {
          DP-1.enable = false;
          HDMI-2.enable = false;
          DP-2.enable = false;
          HDMI-1 = {
            enable = true;
            mode = "3456x1944_30.00";
            position = "0x0";
            primary = true;
            rate = "29.97";
          };
          eDP-1 = {
            enable = true;
            mode = "1920x1080";
            position = "3456x1347";
            rate = "59.93";
          };
        };
      };
    };
  };
  home.file.".xsessionrc".text = builtins.readFile ./programs/x/xsessionrc;

  home.file.".gitignore".text = builtins.readFile ./programs/git/gitignore;
  home.file.".gitconfig".text = builtins.readFile ./programs/git/gitconfig;

  home.file.".config/base16-shell" = {
    source = builtins.fetchTarball "https://github.com/chriskempson/base16-shell/archive/master.tar.gz";
  };

  home.file.".local/share/git-completion.bash" = {
    source = "${builtins.fetchTarball "https://github.com/git/git/archive/master.tar.gz"}/contrib/completion/git-completion.bash";
  };

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

    ${builtins.readFile ./config.sh}

  '' + (
    if builtins.currentSystem != "x86_64-darwin"
      then
        ''
          export LOCALE_ARCHIVE_2_11=${pkgs.glibcLocales}/lib/locale/locale-archive
          export LOCALE_ARCHIVE_2_27=${pkgs.glibcLocales}/lib/locale/locale-archive
          export LOCALE_ARCHIVE=/usr/bin/locale
        ''
      else
        ""
  );

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
    hlint
    htop
    ipcalc
    jq
    libossp_uuid
    lynx
    ncdu
    netcat
    nmap
    ormolu
    ripgrep
    tree
    tshark
    vim-with-packages
  ] ++ lib.optionals (builtins.currentSystem != "x86_64-darwin") [
    xclip
    xsel
  ];
}

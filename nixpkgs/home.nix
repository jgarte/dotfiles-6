{ pkgs, lib, config, ... }:
let
  vim-with-packages = pkgs.vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./programs/vim/vimrc;
    vimrcConfig.packages.default = with pkgs.vimPlugins; {
      start = [
        ale
        base16-vim
        bufexplorer
        editorconfig-vim
        fzf-vim
        fzfWrapper
        nerdtree
        vim-abolish
        vim-better-whitespace
        vim-commentary
        vim-gitgutter
        vim-grammarous
        vim-multiple-cursors
        vim-polyglot
        vim-sensible
        vim-surround
        vim-test
      ];
    };
  };

  rufo = pkgs.callPackage ({ buildRubyGem, ruby }:
    buildRubyGem rec {
      inherit ruby;
      gemName = "rufo";
      version = "0.12.0";
      source.sha256 = "0nwasskcm0nrf7f52019x4fvxa5zckj4fcvf4cdl0qflrcwb1l9f";
    }) {};

  gifit = { runtimeShell, ffmpeg, writeScriptBin }:
    writeScriptBin "gifit" ''
      #!${runtimeShell}

      ${ffmpeg}/bin/ffmpeg \
        -i $1 \
        -filter_complex "[0:v] fps=12,scale=720:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" \
        $2
    '';

  scripts = [
    (pkgs.callPackage gifit {})
  ];
in
rec {
  imports = [
    ./programs/termonad/module.nix
    ./modules/roboto-fonts.nix
    ./modules/fira-fonts.nix
    ./modules/firefox-with-desktop-entry.nix
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
    plugins = [];
    terminal = "screen-256color";
  };

  programs.alacritty = {
    enable = builtins.currentSystem == "x86_64-darwin";
    settings = {
      shell = {
        program = "${programs.tmux.package}/bin/tmux";
        args = [ "attach" ];
      };
      font = {
        size = 18;
        normal = {
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          family = "Fira Code";
          style = "Italic";
        };
      };
    };
  };

  programs.termonad = {
    enable = builtins.currentSystem != "x86_64-darwin";
    configuration = builtins.readFile ./programs/termonad/termonad.hs;
  };

  programs.firefox-with-desktop-entry = {
    enable = builtins.currentSystem != "x86_64-darwin";
  };

  fira-fonts.enable = true;

  roboto-fonts.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

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
            mode = "2880x1620_30.00";
            position = "1920x0";
            primary = true;
            rate = "30.00";
          };
          eDP-1 = {
            enable = true;
            mode = "1920x1080";
            position = "0x1178";
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
    source = builtins.fetchTarball {
      url = "https://github.com/chriskempson/base16-shell/archive/ce8e1e540367ea83cc3e01eec7b2a11783b3f9e1.tar.gz";
      sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
    };
  };

  home.file.".local/share/git-completion.bash" = {
    source = "${builtins.fetchTarball {
      url = "https://github.com/git/git/archive/2befe97201e1f3175cce557866c5822793624b5a.tar.gz";
      sha256 = "1mz0arnnd715jl891yg8hjplkm4hgn7pxhwfva5lbda801nps2r7";
    }}/contrib/completion/git-completion.bash";
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
    ${builtins.readFile ./programs/bash/preview-rg.sh}
    ${builtins.readFile ./programs/bash/prompt.sh}
    ${builtins.readFile ./programs/bash/reload.sh}
    ${builtins.readFile ./programs/bash/rust.sh}
    ${builtins.readFile ./programs/bash/title.sh}

    if [ ! -z $BASE16_THEME ]; then
      source ${builtins.fetchTarball {
        url = "https://github.com/fnune/base16-fzf/archive/ef4c386689f18bdc754a830a8e66bc2d46d515ae.tar.gz";
        sha256 = "1hcr9sq3bxnin2b1pn9dzw39ddxsx1a0fr075l62yn9203fvq0hq";
      }}/bash/base16-$BASE16_THEME.config
    fi

    ${builtins.readFile ./config.sh}

  '' + pkgs.lib.optionalString pkgs.stdenv.isLinux ''
      export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
  '';

  home.packages = with pkgs; [
    bandwhich
    bash-completion
    bashInteractive
    cabal-install
    coreutils
    direnv
    entr
    exa
    fd
    fzf
    ghc
    git
    haskellPackages.ghcid
    haskellPackages.hlint
    htop
    hyperfine
    ipcalc
    jq
    libossp_uuid
    lorri
    lynx
    ncdu
    netcat
    nmap
    dnsutils
    ormolu
    procs
    ripgrep
    rufo
    sd
    tokei
    tree
    vim-with-packages
    vulnix
    ytop
  ] ++ lib.optionals (builtins.currentSystem != "x86_64-darwin") [
    xclip
    xsel
  ] ++ scripts;
}

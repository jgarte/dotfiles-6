{
  packageOverrides = pkgs : with pkgs; rec {
    all = buildEnv {
      name = "all";
      paths = [
        bash-completion
        bashInteractive
        coreutils
        fd
        fzf
        git
        htop
        ncdu
        powerline-fonts
        ripgrep
        tmux
        tree
        vim
      ];
    };
  };
}

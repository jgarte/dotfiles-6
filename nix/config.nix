{
  packageOverrides = pkgs : with pkgs; rec {
    all = buildEnv {
      name = "all";
      paths = [
        asciinema
        bash-completion
        bashInteractive
        cabal-install
        cabal2nix
        coreutils
        darcs
        entr
        fd
        fzf
        ghc
        git
        haskellPackages.ghcid
        haskellPackages.hindent
        hlint
        htop
        jq
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

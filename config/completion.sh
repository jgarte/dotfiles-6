if [ -f ~/.nix-profile/share/bash-completion/bash_completion ]; then
  . ~/.nix-profile/share/bash-completion/bash_completion
fi

if [ -f ~/.local/share/git-completion.bash ]; then
  . ~/.local/share/git-completion.bash

  if [ -x "$(type -t g)" ]; then
    __git_complete g _git
  fi
fi

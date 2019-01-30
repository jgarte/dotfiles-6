alias g=git

if [ -f ~/.local/share/git-completion.bash ]; then
  . ~/.local/share/git-completion.bash

  __git_complete g _git
fi

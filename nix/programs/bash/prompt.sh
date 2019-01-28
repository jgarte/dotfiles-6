# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

git_dirty () {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    printf "[+]"
  else
    printf ""
  fi
}

git_branch () {
  local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ "$branch" != "" ]]; then
    printf "[$branch]"
  else
    printf ""
  fi
}

nix_shell_status () {
  if [ ! -z $IN_NIX_SHELL ]; then
    printf "[nix:$name]"
  else
    printf ""
  fi
}

background_jobs () {
  local job_count=$(jobs | wc -l)
  if [[ $job_count != "0" ]]; then
    printf "[jobs:$job_count]"
  else
    printf ""
  fi
}

status_bar () {
  printf "$(background_jobs)$(nix_shell_status)$(git_branch)$(git_dirty)"
}

if [ "$color_prompt" = yes ]; then
  PS1="\[\e[01;32m\]\u@\h\[\e[m\] \$(status_bar)\n\[\e[01;34m\]\w\[\e[m\] » "
else
  PS1="\u@\h \$(status_bar)\n\w » "
fi

unset color_prompt force_color_prompt

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

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

if [ "$color_prompt" = yes ]; then
  PS1="\[\e[01;32m\]\u@\h\[\e[m\] \$(nix_shell_status)\$(git_branch)\$(git_dirty)\n\[\e[01;34m\]\w\[\e[m\] » "
else
  PS1="\u@\h\$(nix_shell_status)\$(git_branch)\$(git_dirty)\n\w » "
fi
unset color_prompt force_color_prompt

fcd () {
  cd "$(fd -t d $@ | fzf)"
}

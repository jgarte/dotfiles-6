prg () {
  rg $@ -l | fzf --preview "rg --pretty --context 10 $@ {}"
}

function c () {
  cd $HOME/code/$1
}
compctl -W $HOME/code -/ c

function edh () {
  cd $HOME/code/edh/$1
}
compctl -W $HOME/code/edh -/ edh

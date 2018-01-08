export CHRUBY_DIR="$HOME/.chruby"
[ -s "$CHRUBY_DIR/share/chruby/chruby.sh" ] && . "$CHRUBY_DIR/share/chruby/chruby.sh"
[ -s "$CHRUBY_DIR/share/chruby/auto.sh" ] && . "$CHRUBY_DIR/share/chruby/auto.sh"
if [ -x "$(command -v chruby)" ]; then
  chruby 2.4.1
fi

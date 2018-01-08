EDH_DIR="$HOME/code/edh"
if [ -d "$EDH_DIR" ]; then
  export CDPATH="${CDPATH:-'.'}:$EDH_DIR"
fi

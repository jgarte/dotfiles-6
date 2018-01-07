DIR=/usr/local/opt/coreutils/libexec/gnubin
if [ -d "$DIR" ]; then
  export PATH="$DIR:$PATH"
fi

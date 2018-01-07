if ! [ -x "$(command -v pbcopy)" ]; then
  alias pbcopy='xclip -selection clipboard'
fi

if ! [ -x "$(command -v pbpaste)" ]; then
  alias pbpaste='xclip -selection clipboard -o'
fi

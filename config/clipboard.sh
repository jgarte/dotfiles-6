if ! [ command -v pbcopy >/dev/null 2>&1 ]; then
  alias pbcopy='xclip -selection clipboard'
fi

if ! [ command -v pbpaste >/dev/null 2>&1 ]; then
  alias pbpaste='xclip -selection clipboard -o'
fi

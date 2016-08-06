ZSH=$HOME/.oh-my-zsh
ZSH_THEME="minimal"
DISABLE_AUTO_UPDATE="true"

UNBUNDLED_COMMANDS=(foreman)
plugins=(git bundler brew gem rbates)

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export EDITOR='vim'

# NVM
export NODE_PATH="$HOME/.node/lib/node_modules"
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc

# Chruby
source ~/.chruby/share/chruby/chruby.sh
source ~/.chruby/share/chruby/auto.sh
chruby 2.3.1

source $ZSH/oh-my-zsh.sh

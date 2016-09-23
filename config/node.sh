export NODE_PATH="$HOME/.node/lib/node_modules"
export NVM_DIR="$HOME/code/edh/.nvm"
source "$NVM_DIR/nvm.sh"
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc

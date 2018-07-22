# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then

  zgen load unixorn/autoupdate-zgen
  zgen prezto
  zgen prezto git
  zgen prezto command-not-found
  zgen prezto tmux
  zgen load Seinh/git-prune
  zgen load djui/alias-tips
  zgen load supercrabtree/k
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen prezto history-substring-search
  zgen load supercrabtree/k
  zgen save
fi

plugins=(
  tmuxinator
)


# Set terminal color
export TERM=xterm-256color

# prompt cloud ❦ yellow
prompt pure

# Allow typing comments in interactive mode
setopt interactivecomments

# Setup VIM as default editor
export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

KEYTIMEOUT=1

# Setup tmux autostart
zstyle ':prezto:module:tmux:auto-start' local 'yes'
zstyle ':prezto:module:tmux:auto-start' remote 'yes'

# Load custom configuration
if test -s ~/.zsh_custom; then
  source ~/.zsh_custom
fi

export PATH="/usr/local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

export PATH="$HOME/.yarn/bin:$PATH"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

alias mux="tmuxinator"

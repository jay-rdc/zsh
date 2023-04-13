### =======ENV VARIABLES======= ###

[ ! -d "$XDG_CACHE_HOME/zsh" ] && mkdir -p "$XDG_CACHE_HOME/zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000

### =======PROMPT SETTINGS======= ###

autoload -Uz vcs_info

precmd() { vcs_info }

zstyle ":vcs_info:git:*" formats " on %F{014}שׂ %b%f"
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors ""

setopt PROMPT_SUBST
PROMPT='%B%F{011}ﱮ %1~%f${vcs_info_msg_0_}%b %F{010}%f '

### =======ALIASES======= ###

alias ls="ls --color=auto"
alias ll="ls -lh"
alias cp="cp -iv"
alias mv="mv -iv"

function mdcd { mkdir -pv $1 && cd $1 }
alias mdcd=mdcd

### =======KEYBINDINGS======= ###

zmodload zsh/complist

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

### =======MISC======= ###

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### =======PLUGINS======= ###

function plugin {
  [ ! -d "$ZDOTDIR/plugins/$(basename $1)" ] && git clone https://github.com/$1.git $ZDOTDIR/plugins/$(basename $1)
  source "$ZDOTDIR/plugins/$(basename $1)/$(basename $1).zsh"
}

plugin zsh-users/zsh-autosuggestions

# must be at last line
plugin zsh-users/zsh-syntax-highlighting

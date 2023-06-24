if [ -z "$TMUX" ]; then
  tmux has 2> /dev/null
  [ $? -eq 1 ] && tmux new || tmux attach 2> /dev/null
fi

### =======ENV VARIABLES======= ###

HISTSIZE=10000
SAVEHIST=10000
[ ! -d "$XDG_CACHE_HOME/zsh" ] && mkdir -p "$XDG_CACHE_HOME/zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/history.zsh"

### =======PROMPT======= ###

autoload -Uz vcs_info

precmd() { vcs_info }

zstyle ":vcs_info:git:*" formats " on %F{cyan} %b%f"
zstyle ":vcs_info:git:*" actionformats " on %F{cyan} %b (%f%F{red}%a%f%F{cyan})%f"

setopt PROMPT_SUBST
PROMPT='%B%F{yellow} %1~%f${vcs_info_msg_0_} %F{green}%f%b '

### =======COMPLETION======= ###

eval $(dircolors -b)

zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}

zmodload zsh/complist

### =======ALIASES======= ###

alias nv="nvim"
alias ls="ls --color=auto"
alias ll="ls -lh"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias rmdir="rmdir -v"

### =======FUNCTIONS======= ###

mdcd() { mkdir $1 && cd $1 }

fp() {
  local project_dir=$(fd . $HOME/projects -td | fzf)
  [ -n "$project_dir" ] && cd $project_dir
}

### =======KEYBINDINGS======= ###

bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

bindkey "^j" autosuggest-accept

### =======MISC======= ###

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### =======PLUGINS======= ###

__zsh_plugin() {
  local plugin_dir="$ZDOTDIR/plugins/$(basename $1)"
  local plugin_script="$plugin_dir/$(basename $1).zsh"

  [ ! -d $plugin_dir ] && git clone https://github.com/$1.git $plugin_dir
  [ -s $plugin_script ] && source $plugin_script
}

__zsh_plugin zsh-users/zsh-autosuggestions

# must be at last line
__zsh_plugin zsh-users/zsh-syntax-highlighting

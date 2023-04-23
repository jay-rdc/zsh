### =======ENV VARIABLES======= ###

[ ! -d "$XDG_CACHE_HOME/zsh" ] && mkdir -p "$XDG_CACHE_HOME/zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/history.zsh"
HISTSIZE=1000
SAVEHIST=1000

### =======PROMPT SETTINGS======= ###

autoload -Uz vcs_info
eval $(dircolors -b)

precmd() { vcs_info }

zstyle ":vcs_info:git:*" formats " on %F{014}שׂ %b%f"
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}

setopt PROMPT_SUBST
PROMPT='%B%F{011}ﱮ %1~%f${vcs_info_msg_0_}%b %F{010}%f '

### =======ALIASES/FUNCTIONS======= ###

alias ls="ls --color=auto"
alias ll="ls -lh"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkdir="mkdir -pv"
alias rmdir="rmdir -v"

mdcd() { mkdir $1 && cd $1 }

fp() {
  local project_dir=$(fd . $HOME/projects -td -E node_modules | fzf)
  [ -n "$project_dir" ] && cd $project_dir
}

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

plugin() {
  local plugin_dir="$ZDOTDIR/plugins/$(basename $1)"
  local plugin_script="$plugin_dir/$(basename $1).zsh"

  [ ! -d $plugin_dir ] && git clone https://github.com/$1.git $plugin_dir
  [ -s $plugin_script ] && source $plugin_script
}

plugin zsh-users/zsh-autosuggestions

# must be at last line
plugin zsh-users/zsh-syntax-highlighting

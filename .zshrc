### =======ENV VARIABLES======= ###

[ ! -d "$HOME/.cache/zsh" ] && mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000

### =======PROMPT SETTINGS======= ###

autoload -U colors && colors
autoload -Uz vcs_info

precmd() { vcs_info }

zstyle ":vcs_info:git:*" formats "(%b)"
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors ""

zmodload zsh/complist

setopt PROMPT_SUBST
PROMPT='
%{$fg_bold[green]%}%0~ %{$fg_bold[blue]%}${vcs_info_msg_0_}%{$reset_color%}
%F{011}$%f '

### =======ALIASES======= ###

alias ls="ls --color=auto"
alias ll="ls -l"

### =======KEYBINDINGS======= ###

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

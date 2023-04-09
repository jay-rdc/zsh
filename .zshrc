### =======ENV VARIABLES======= ###

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
%{$fg_bold[green]%}%0~ %{$fg_bold[blue]%}${vcs_info_msg_0_}
%{$reset_color%}$ '

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

# zsh autosuggestions
if [ ! -d "$ZDOTDIR/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/plugins/zsh-autosuggestions
fi
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh syntax highlighting
if [ ! -d "$ZDOTDIR/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting
fi
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

### =======EXPORTS=======

export CLICOLOR=1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### =======PROMPT SETTINGS=======

autoload -U colors && colors
autoload -Uz vcs_info

precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':completion:*' menu select

setopt PROMPT_SUBST
PROMPT='
%{$fg_bold[green]%}%0~ %{$fg_bold[blue]%}${vcs_info_msg_0_}
%{$reset_color%}$ '

### =======PLUGINS=======

ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"

# zsh autosuggestions
if [ ! -d "${ZSH_PLUGIN_DIR}/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_PLUGIN_DIR}/zsh-autosuggestions
fi
source "${ZSH_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh syntax highlighting
if [ ! -d "${ZSH_PLUGIN_DIR}/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_PLUGIN_DIR}/zsh-syntax-highlighting
fi
source "${ZSH_PLUGIN_DIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

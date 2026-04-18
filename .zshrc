# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  print -P "%F{cyan}Installing zinit...%f"
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Completions
autoload -U compinit && compinit
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':fzf-tab:*' fzf-flags --style full --height 40%
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -2 --color=always $realpath'

# Plugins
zinit ice depth=1
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit cdreplay -q

# Starship
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# History
HISTFILE=~/.shell_zsh_history
HISTSIZE=20000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPEND_HISTORY HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_DUPS HIST_VERIFY
setopt SHARE_HISTORY EXTENDED_HISTORY

# Shell options
setopt PROMPT_SUBST AUTO_CD CORRECT NO_BEEP GLOB_DOTS
precmd() { print -n "\033]0;${PWD}\007" }

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CMD_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
  --style full
  --height ~80%
  --min-height=10
  --layout=reverse
  --border-label=' fzf '
  --border-label-pos=3
  --prompt='  '
  --pointer='➜'
  --marker='✓'
  --scrollbar='│'
"
export FZF_CTRL_T_OPTS="
--preview 'bat --style=numbers,changes --color=always --line-range=:80 {}'
--bind 'ctrl-/:toggle-preview'
"
export FZF_ALT_C_OPTS="
  --preview 'eza --tree --color=always --icons --level=2 {}'
  --bind 'ctrl-/:toggle-preview'
"

# Keybindings
bindkey -v
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^R' history-incremental-search-backward
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Zoxide
eval "$(zoxide init zsh)"

# Aliases — eza
alias l='eza --long --tree --level=1 --all --icons --group-directories-last --git-repos --git --no-permissions --no-filesize --no-user --no-time'
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lha --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias lt3='eza --tree --icons --level=3'

# Aliases — bat
export BAT_THEME="base16"
alias cat='bat --paging=never'
alias less='bat --paging=always'

# Aliases — geral
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias nvi='nvim $(fzf --style full -m --preview="bat --color=always {}")'
alias lg='lazygit'
alias lzd='lazydocker'
alias cd='z'
alias cdi='zi'
alias minikctl="minikube kubectl"
# Alias recomendado no .zshrc
alias brew-up='brew update && brew upgrade'

# bun completions
[ -s "/Users/solomon/.bun/_bun" ] && source "/Users/solomon/.bun/_bun"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/solomon/.config/sdkman"
[[ -s "/Users/solomon/.config/sdkman/bin/sdkman-init.sh" ]] && source "/Users/solomon/.config/sdkman/bin/sdkman-init.sh"

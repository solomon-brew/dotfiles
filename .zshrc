# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load omarchy-zsh configuration
if [[ -d /usr/share/omarchy-zsh/conf.d ]]; then
  for config in /usr/share/omarchy-zsh/conf.d/*.zsh; do
    [[ -f "$config" ]] && source "$config"
  done
fi

# Load omarchy-zsh functions and aliases
if [[ -d /usr/share/omarchy-zsh/functions ]]; then
  for func in /usr/share/omarchy-zsh/functions/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi

# Add your own customizations below

# export DIRENV_LOG_FORMAT=""

if command -v keychain >/dev/null 2>&1; then
    eval $(keychain --quiet --eval id_github)
fi

# Editor
EDITOR='nvim'

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export GOTELEMETRY=off

# ── fzf ──────────────────────────────────────
[[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
[[ -f /usr/share/fzf/shell/completion.zsh   ]] && source /usr/share/fzf/shell/completion.zsh

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

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


# fzf defaut configs
# export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --style full"
# export FZF_DEFAULT_OPTS="--layout reverse --height 60% --border full"
# export FZF_CTRL_T_OPTS="--style full --walker-skip .git,node_modules,target --preview 'bat --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# export FZF_ALT_C_OPTS="--style full --preview 'eza --tree --level=2 --color=always --all --icons {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# export FZF_CTRL_R_OPTS="--style full --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Habilita substituição de variáveis no prompt e define o título do terminal como o diretório atual
setopt PROMPT_SUBST
precmd() { print -n "\033]0;${PWD}\007" }

# Zinit
# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  print -P "%F{cyan}Installing zinit...%f"
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"
# Load Completions
autoload -U compinit && compinit
# Completion Styling
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':fzf-tab:*' fzf-flags --style full --height 40%
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -2 --color=always $realpath'

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Otimização para carregar plugins com shallow clone (mais rápido)
zinit ice depth=1

# Integração do FZF com o autocompletar
zinit light Aloxaf/fzf-tab

# Plugins essenciais da comunidade zsh-users
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# Zinit pede pra colocar isso pra ajeitar ordem de carregamento dos plugins \_('-')_/
zinit cdreplay -q

# History
HISTFILE=~/.shell_zsh_history
HISTSIZE=20000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Shell integrations
# eval "$(direnv hook zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# ── KEYBINDIGNS ───────────────────────────────────────

# ── vi mode ───────────────────────────────────
bindkey -v
# Set kj as escape
bindkey -M viins 'kj' vi-cmd-mode
# Restore useful emacs bindings in insert mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^H' backward-delete-char   # Backspace
bindkey -M viins '^?' backward-delete-char   # Backspace (some terminals)
bindkey -M viins '^R' history-incremental-search-backward


bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ── eza ───────────────────────────────────────
alias l='eza --long --tree --level=1 --all --icons --group-directories-last --git-repos --git --no-permissions --no-filesize --no-user --no-time'
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first --git'
alias la='eza -lha --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias lt3='eza --tree --icons --level=3'

# ── bat ───────────────────────────────────────
export BAT_THEME="base16"
alias cat='bat --paging=never'
alias less='bat --paging=always'

# ── zoxide ────────────────────────────────────
eval "$(zoxide init zsh)"
alias cd='z'
alias cdi='zi'


# ── Quality of life ───────────────────────────
setopt AUTO_CD
setopt CORRECT
setopt NO_BEEP
setopt GLOB_DOTS

alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias nvi='nvim $(fzf --style full -m --preview="bat --color=always {}")'
alias lg='lazygit'
alias minikctl="minikube kubectl"

# nvm requires
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load Angular CLI autocompletion.
# source <(ng completion script)
alias lzd='lazydocker'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.config/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# bun completions
[ -s "/home/solomon-brew/.bun/_bun" ] && source "/home/solomon-brew/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

PROMPT='%F{green}%n@%m%f %F{blue}%~%f %F{cyan}❯%f '

#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

unset ZSH ZSH_CUSTOM ZSH_CACHE_DIR plugins

# 长命令执行时间统计
REPORTTIME=5

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history

alias ls='ls --color=auto'
alias ll='ls -alhF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

alias grep='grep --color=auto'

alias clip='xclip -selection clipboard'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# 补全列表颜色
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 选中项高亮
zstyle ':completion:*' menu select=1

# 补全：先精确匹配，找不到再忽略大小写
zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-zA-Z}={A-Za-z}'

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

#if [[ -r /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
#  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
#fi

if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

if [[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# =========================
# Autosuggestions
# 历史命令自动补全
# =========================

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

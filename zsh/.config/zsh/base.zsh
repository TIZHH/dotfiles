# Shared Zsh configuration. Powerlevel10k is loaded directly without Oh My Zsh.
unset ZSH ZSH_CUSTOM ZSH_CACHE_DIR plugins

REPORTTIME=5

# ===== History =====
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# ===== Common aliases =====
alias ls='ls --color=auto'
alias ll='ls -alhF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias clip='wl-copy'

# ===== Completion =====
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# ===== Optional tools and plugins =====
if [[ -o interactive && -t 0 ]] && command -v fzf >/dev/null 2>&1; then
    # This is the same integration that Oh My Zsh's fzf plugin used. It opens
    # the Ctrl+R history popup and seeds the query with the current LBUFFER.
    # Clear the custom value used by an earlier dotfiles revision.
    unset FZF_CTRL_R_OPTS
    eval "$(fzf --zsh)"
fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

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

# ===== Prompt =====
if [[ -r /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
else
    PROMPT='%F{green}%n@%m%f %F{blue}%~%f %F{cyan}❯%f '
fi

# Syntax highlighting should be loaded after the other shared plugins.
if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

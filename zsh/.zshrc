# Load the shared shell behavior first. This replaces CachyOS/Oh My Zsh.
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/base.zsh"

# Secret values stay outside Git. See ~/.zshrc.secrets.example.
secrets_file="${ZSH_SECRETS_FILE:-$HOME/.zshrc.secrets}"
[[ -r "$secrets_file" ]] && source "$secrets_file"
unset secrets_file

# ===== Proxy =====
PROXY_HOST="127.0.0.1"
PROXY_PORT="7897"

setproxy() {
    export http_proxy="http://$PROXY_HOST:$PROXY_PORT"
    export https_proxy="http://$PROXY_HOST:$PROXY_PORT"
    export all_proxy="socks5://$PROXY_HOST:$PROXY_PORT"
    export HTTP_PROXY="$http_proxy"
    export HTTPS_PROXY="$https_proxy"
    export ALL_PROXY="$all_proxy"
    echo "Proxy ON ($PROXY_HOST:$PROXY_PORT)"
}

unsetproxy() {
    unset http_proxy https_proxy all_proxy
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
    echo "Proxy OFF"
}

proxy_status() {
    echo "http_proxy=${http_proxy:-<unset>}"
    echo "https_proxy=${https_proxy:-<unset>}"
    echo "all_proxy=${all_proxy:-<unset>}"
}

# ===== Claude providers =====
cc_ofoxai() {
    if [[ -z "${OFOXAI_ANTHROPIC_AUTH_TOKEN:-}" ]]; then
        echo "OFOXAI_ANTHROPIC_AUTH_TOKEN is not set in ~/.zshrc.secrets" >&2
        return 1
    fi

    unset ANTHROPIC_MODEL ANTHROPIC_DEFAULT_OPUS_MODEL ANTHROPIC_DEFAULT_SONNET_MODEL
    unset ANTHROPIC_DEFAULT_HAIKU_MODEL CLAUDE_CODE_SUBAGENT_MODEL CLAUDE_CODE_EFFORT_LEVEL
    export ANTHROPIC_BASE_URL="https://api.ofox.ai/anthropic"
    export ANTHROPIC_AUTH_TOKEN="$OFOXAI_ANTHROPIC_AUTH_TOKEN"
    export ANTHROPIC_MODEL="claude-opus-4-7"
    cc_status
}

cc_dsv4() {
    if [[ -z "${DEEPSEEK_ANTHROPIC_AUTH_TOKEN:-}" ]]; then
        echo "DEEPSEEK_ANTHROPIC_AUTH_TOKEN is not set in ~/.zshrc.secrets" >&2
        return 1
    fi

    export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
    export ANTHROPIC_AUTH_TOKEN="$DEEPSEEK_ANTHROPIC_AUTH_TOKEN"
    export ANTHROPIC_MODEL="deepseek-v4-pro[1m]"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-v4-pro[1m]"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-v4-pro[1m]"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="deepseek-v4-flash"
    export CLAUDE_CODE_SUBAGENT_MODEL="deepseek-v4-flash"
    export CLAUDE_CODE_EFFORT_LEVEL="max"
    cc_status
}

cc_status() {
    echo "ANTHROPIC_BASE_URL=${ANTHROPIC_BASE_URL:-<unset>}"
    echo "ANTHROPIC_MODEL=${ANTHROPIC_MODEL:-<unset>}"
    if [[ -n "${ANTHROPIC_AUTH_TOKEN:-}" ]]; then
        echo "ANTHROPIC_AUTH_TOKEN=<set>"
    else
        echo "ANTHROPIC_AUTH_TOKEN=<unset>"
    fi
}

# ===== Codex profiles =====
_codex_home() {
    local name="$1"
    shift

    local codex_home="$HOME/.codex-homes/$name"
    if [[ ! -d "$codex_home" ]]; then
        echo "Codex home not found: $codex_home" >&2
        return 1
    fi

    CODEX_HOME="$codex_home" command codex "$@"
}

codex_official() {
    _codex_home official "$@"
}

codex_daseinai() {
    _codex_home daseinai "$@"
}

# ===== Local network =====
connect_hotspot() {
    if [[ -z "${HOTSPOT_PASSWORD:-}" ]]; then
        echo "HOTSPOT_PASSWORD is not set in ~/.zshrc.secrets" >&2
        return 1
    fi

    local ssid="${HOTSPOT_SSID:-zh}"
    nmcli device wifi rescan
    nmcli device wifi connect "$ssid" password "$HOTSPOT_PASSWORD"
}

# ===== Development environment =====
export NEMU_HOME="$HOME/Workspace/icspa/ics2025/nemu"
export AM_HOME="$HOME/Workspace/icspa/ics2025/abstract-machine"
export NAVY_HOME="$HOME/Workspace/icspa/ics2025/navy-apps"
export PATH="$HOME/.local/bin:$PATH"

alias get_idf='. "$HOME/Workspace/esp32/esp-idf/export.sh"'

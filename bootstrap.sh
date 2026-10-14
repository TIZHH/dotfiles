#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
package_dir="$repo_dir/packages"
stow_packages=(hypr waybar wofi kitty wallpapers zsh)
overwrite_sources=(
    hypr/.config/hypr
    kitty/.config/kitty
    zsh/.zshrc
    zsh/.p10k.zsh
    zsh/.zshrc.secrets.example
)
overwrite_targets=(
    .config/hypr
    .config/kitty
    .zshrc
    .p10k.zsh
    .zshrc.secrets.example
)
backup_dir=""
declare -a moved_targets=()
declare -a moved_backups=()

usage() {
    cat <<'EOF'
Usage: ./bootstrap.sh [--install]

  --install  Install the desktop packages with pacman before linking configs.

Without --install, only the config links are created. Existing Hyprland, Kitty,
and Zsh targets are backed up and replaced; other conflicts stop GNU Stow.
EOF
}

install_packages=false
case "${1:-}" in
    "") ;;
    --install) install_packages=true ;;
    -h|--help)
        usage
        exit 0
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac

if "$install_packages"; then
    if ! command -v pacman >/dev/null 2>&1; then
        echo "error: pacman is required to install packages" >&2
        exit 1
    fi

    mapfile -t package_files < <(find "$package_dir" -maxdepth 1 -type f -name '*.txt' -print | sort)
    if ((${#package_files[@]} == 0)); then
        echo "error: no package lists found in $package_dir" >&2
        exit 1
    fi

    mapfile -t desktop_packages < <(
        sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' "${package_files[@]}" | sort -u
    )
    sudo pacman -S --needed "${desktop_packages[@]}"
fi

if ! command -v stow >/dev/null 2>&1; then
    echo "error: GNU Stow is not installed; run ./bootstrap.sh --install first" >&2
    exit 1
fi

mkdir -p "$HOME/.config" "$HOME/Pictures/papers"

backup_conflicts() {
    local index source relative target backup

    for index in "${!overwrite_targets[@]}"; do
        relative="${overwrite_targets[$index]}"
        source="$repo_dir/${overwrite_sources[$index]}"
        target="$HOME/$relative"

        if [[ ! -e "$target" && ! -L "$target" ]]; then
            continue
        fi

        if [[ "$(readlink -f -- "$target")" == "$(readlink -f -- "$source")" ]]; then
            continue
        fi

        if [[ -z "$backup_dir" ]]; then
            backup_dir="$HOME/.local/state/dotfiles-backup/$(date +%Y%m%d-%H%M%S)-bootstrap-$$"
        fi

        backup="$backup_dir/$relative"
        mkdir -p "$(dirname -- "$backup")"
        mv -- "$target" "$backup"
        moved_targets+=("$target")
        moved_backups+=("$backup")
        echo "Backed up $target"
    done
}

restore_conflicts() {
    local index target backup

    for ((index = ${#moved_targets[@]} - 1; index >= 0; index--)); do
        target="${moved_targets[$index]}"
        backup="${moved_backups[$index]}"

        if [[ -L "$target" || -f "$target" ]]; then
            rm -f -- "$target"
        elif [[ -d "$target" ]]; then
            rmdir -- "$target" 2>/dev/null || true
        fi

        mkdir -p "$(dirname -- "$target")"
        mv -- "$backup" "$target"
        echo "Restored $target"
    done
}

rollback() {
    local status="$1"
    trap - ERR INT TERM
    set +e
    restore_conflicts
    exit "$status"
}

trap 'rollback $?' ERR
trap 'rollback 130' INT
trap 'rollback 143' TERM
backup_conflicts

# Check every package first so a conflict cannot leave a partially linked setup.
stow --dir "$repo_dir" --target "$HOME" --simulate --restow "${stow_packages[@]}"
stow --dir "$repo_dir" --target "$HOME" --restow "${stow_packages[@]}"
trap - ERR INT TERM

echo "Dotfiles linked successfully."
if [[ -n "$backup_dir" ]]; then
    echo "Previous Hyprland/Kitty/Zsh files were saved to $backup_dir"
fi

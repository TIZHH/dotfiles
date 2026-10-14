#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
package_dir="$repo_dir/packages"
stow_packages=(hypr waybar wofi kitty wallpapers zsh)

usage() {
    cat <<'EOF'
Usage: ./bootstrap.sh [--install]

  --install  Install the desktop packages with pacman before linking configs.

Without --install, only the config links are created. Existing unmanaged files
are never overwritten; GNU Stow will stop and report conflicts.
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

# Check every package first so a conflict cannot leave a partially linked setup.
stow --dir "$repo_dir" --target "$HOME" --simulate --restow "${stow_packages[@]}"
stow --dir "$repo_dir" --target "$HOME" --restow "${stow_packages[@]}"

echo "Dotfiles linked successfully."

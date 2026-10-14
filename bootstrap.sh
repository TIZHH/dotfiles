#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
package_file="$repo_dir/packages/hyprland.txt"
stow_packages=(hypr waybar wofi kitty wallpapers)

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
    mapfile -t desktop_packages < <(sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' "$package_file")
    sudo pacman -S --needed "${desktop_packages[@]}"
fi

if ! command -v stow >/dev/null 2>&1; then
    echo "error: GNU Stow is not installed; run ./bootstrap.sh --install first" >&2
    exit 1
fi

mkdir -p "$HOME/.config" "$HOME/Pictures/papers"

for package in "${stow_packages[@]}"; do
    stow --dir "$repo_dir" --target "$HOME" --restow "$package"
done

echo "Dotfiles linked successfully."

#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
timestamp="$(date +%Y%m%d-%H%M%S)"

packages=(hypr waybar wofi kitty wallpapers zsh)
package_targets=(
    ".config/hypr"
    ".config/waybar"
    ".config/wofi"
    ".config/kitty"
    "Pictures/papers/pexels-splitshire-1562.jpg"
    ".zshrc;.p10k.zsh;.zshrc.secrets.example"
)

if ! command -v stow >/dev/null 2>&1; then
    echo "error: GNU Stow is not installed; run ./install-packages.sh first" >&2
    exit 1
fi

echo "The following paths will be linked:"
for index in "${!packages[@]}"; do
    IFS=';' read -r -a targets <<< "${package_targets[$index]}"
    for relative in "${targets[@]}"; do
        printf '  %-12s %s\n' "[${packages[$index]}]" "$HOME/$relative"
    done
done
echo

mkdir -p "$HOME/.config" "$HOME/Pictures/papers"

for index in "${!packages[@]}"; do
    package="${packages[$index]}"
    IFS=';' read -r -a targets <<< "${package_targets[$index]}"
    moved_targets=()
    backups=()

    echo "==> Linking $package"

    for relative in "${targets[@]}"; do
        source="$repo_dir/$package/$relative"
        target="$HOME/$relative"

        if [[ ! -e "$source" && ! -L "$source" ]]; then
            echo "error: repository file is missing: $source" >&2
            exit 1
        fi

        if [[ ! -e "$target" && ! -L "$target" ]]; then
            echo "    missing: $target"
            continue
        fi

        if [[ "$(readlink -f -- "$target")" == "$(readlink -f -- "$source")" ]]; then
            echo "    linked:  $target"
            continue
        fi

        backup="$target.backup-$timestamp-$$"
        mv -- "$target" "$backup"
        moved_targets+=("$target")
        backups+=("$backup")
        echo "    backup:  $backup"
    done

    if ! stow --dir "$repo_dir" --target "$HOME" --restow "$package"; then
        echo "error: failed to link $package; restoring its backups" >&2

        for ((restore_index = ${#moved_targets[@]} - 1; restore_index >= 0; restore_index--)); do
            target="${moved_targets[$restore_index]}"
            backup="${backups[$restore_index]}"

            if [[ -L "$target" || -f "$target" ]]; then
                rm -f -- "$target"
            elif [[ -d "$target" ]]; then
                rmdir -- "$target" 2>/dev/null || true
            fi

            mv -- "$backup" "$target"
        done

        exit 1
    fi
done

echo
echo "Dotfiles linked successfully."
echo "Existing files were kept as *.backup-$timestamp-$$ next to their original paths."

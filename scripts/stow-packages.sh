#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STOW_DIR="$DOTFILES_DIR/stow"
TARGET_DIR="$HOME"
CONFLICT_PARSER="$DOTFILES_DIR/scripts/stow-conflicts.py"

usage() {
    echo "Usage: $0 [package...]"
    echo ""
    echo "Stow dotfile packages to the filesystem."
    echo "If no packages are specified, all packages are stowed."
    echo ""
    echo "Available packages:"
    for pkg in "$STOW_DIR"/*/; do
        echo "  $(basename "$pkg")"
    done
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
fi

if [[ $# -gt 0 ]]; then
    packages=("$@")
else
    packages=()
    for pkg in "$STOW_DIR"/*/; do
        packages+=("$(basename "$pkg")")
    done
fi

echo "Stowing packages from $STOW_DIR to $TARGET_DIR"

for pkg in "${packages[@]}"; do
    if [[ ! -d "$STOW_DIR/$pkg" ]]; then
        echo "Error: package '$pkg' not found in $STOW_DIR" >&2
        exit 1
    fi

    echo "  -> $pkg"
    tmp_out=$(mktemp)

    if ! stow --dir="$STOW_DIR" --target="$TARGET_DIR" --restow "$pkg" 2>"$tmp_out"; then
        conflicts=$(python3 "$CONFLICT_PARSER" < "$tmp_out")
        rm -f "$tmp_out"

        if [[ -z "$conflicts" ]]; then
            echo "Error: stow failed for '$pkg' (no conflict detected)" >&2
            exit 1
        fi

        while IFS= read -r pair; do
            src="${pair%%:*}"
            target="${pair#*:}"

            echo ""
            echo "Conflict: $src -> $target"
            echo "--- diff (src vs target) ---"
            git diff --no-index -- "$(dirname "$DOTFILES_DIR")/${src}" "${HOME}/${target}" || true
            echo "---"
        done <<< "$conflicts"

        echo ""
        echo "To override all conflicting targets and adopt them into the stow source, run:"
        echo "  stow --dir=\"$STOW_DIR\" --target=\"$TARGET_DIR\" --restow --adopt $pkg"
        echo ""
        echo "To restore the stow source files overwritten by --adopt back to their tracked versions, run:"
        echo "  git -C \"$DOTFILES_DIR\" checkout -- ."
    else
        rm -f "$tmp_out"
    fi
done

echo "Done."

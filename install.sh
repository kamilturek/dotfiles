#!/usr/bin/env bash

set -euo pipefail


QUICK=false

for arg in "$@"; do
    case $arg in
        --quick)
            QUICK=true
            shift
            ;;
    esac
done

ensure_formula_installed() {
    FORMULA="$1"
    if brew list | grep -q "FORMULA"; then
        echo "Installing $FORMULA..."
        brew install "$FORMULA"
    else
        echo "$FORMULA already installed. Skipping."
    fi
}

ensure_tpm_installed() {
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ -d "$TPM_DIR" ]; then
        echo "tpm already installed. Skipping."
    else
        echo "Installing tpm..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    fi
}

link() {
    echo "Linking $1 dotfiles..."
    stow $1 -t $HOME
}

if [ "$QUICK" == false ]; then
    ensure_formula_installed tmux
    ensure_tpm_installed
    ensure_formula_installed stow
fi

link tmux
link vim

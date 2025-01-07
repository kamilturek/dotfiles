#!/usr/bin/env bash

QUICK=false

show_help() {
    echo "Usage: $0 [OPTION ...]"
    echo
    echo "OPTIONS:"
    printf "\t-h, --help\tShow this help\n"
    printf "\t-q, --quick\tRun this script in quick mode, skipping installing dependencies, and only linking dotfiles\n"
}

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

while [[ "$1" != "" ]]; do
    case $1 in
        -h | --help)
            show_help
            exit 0
            ;;
        -q | --quick)
            QUICK=true
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help to see the available options."
            exit 1
            ;;
    esac
    shift
done

if [ "$QUICK" == false ]; then
    ensure_formula_installed tmux
    ensure_tpm_installed
    ensure_formula_installed stow
fi

link tmux
link vim

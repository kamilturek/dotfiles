#!/usr/bin/env bash

set -euo pipefail

ROOT=$PWD/$(dirname "$0")

ln -f -s "$ROOT"/tmux.conf "$HOME"/.tmux.conf
echo "tmux.conf installed."


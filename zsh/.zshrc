# Starship
eval "$(starship init zsh)"

# Autocomplete
autoload -Uz compinit && compinit

# History Browsing
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# fzf
source ~/.fzfrc

# z
source ~/.z.sh

. "$HOME/.local/bin/env"

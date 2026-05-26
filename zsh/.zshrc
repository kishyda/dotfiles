PROMPT="[%F{143}%~%f] %F{242}%#%f "

source $HOME/.config/zsh/oh-my-zsh.zsh

autoload -Uz compinit && compinit
# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# eval "$(starship init zsh)"

eval "$(/opt/homebrew/bin/brew shellenv)"
source <(fzf --zsh)

eval "$(direnv hook zsh)"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
alias switch="sudo darwin-rebuild switch --flake $HOME/dotfiles/nix"

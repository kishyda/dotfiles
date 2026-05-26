PROMPT="[%F{143}%~%f] %F{242}%#%f "

autoload -Uz compinit && compinit
# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [ -x "$brew" ]; then
    eval "$("$brew" shellenv)"
    break
  fi
done

source <(fzf --zsh)

eval "$(direnv hook zsh)"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
case "$(uname)" in
    Darwin)
      alias switch="sudo darwin-rebuild switch --flake $HOME/Dotfiles/nix"
      ;;
    Linux)
      alias switch="home-manager switch --flake $HOME/Dotfiles/nix#keeper-linux"
      ;;
    *)
      echo "Unrecognized architecture, couldn't derive a switch alias"
      ;;
esac

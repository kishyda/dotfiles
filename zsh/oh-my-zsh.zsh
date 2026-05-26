# Enable Powerlevel10k instant prompt.
# This file should be sourced near the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to Oh My Zsh.
#
# Prefer an externally-provided ZSH path, for example from Nix/Home Manager.
# Fallbacks cover common manual installs.
if [[ -z "$ZSH" ]]; then
  if [[ -n "$OH_MY_ZSH_PATH" ]]; then
    export ZSH="$OH_MY_ZSH_PATH"
  elif [[ -d "$HOME/.oh-my-zsh" ]]; then
    export ZSH="$HOME/.oh-my-zsh"
  elif [[ -d /usr/share/oh-my-zsh ]]; then
    export ZSH="/usr/share/oh-my-zsh"
  fi
fi

# Oh My Zsh behavior.
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Oh My Zsh plugins.
#
# Standard plugins must exist in:
#   $ZSH/plugins/<plugin>
#
# Custom plugins must exist in:
#   $ZSH_CUSTOM/plugins/<plugin>
#
# Do not manually source plugin files here.
plugins=(
  git
  fzf
  extract
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search
)

# Load Oh My Zsh.
if [[ -n "$ZSH" && -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  print -u2 "oh-my-zsh.zsh: could not find oh-my-zsh.sh; set ZSH or OH_MY_ZSH_PATH"
fi

# Powerlevel10k prompt config.
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

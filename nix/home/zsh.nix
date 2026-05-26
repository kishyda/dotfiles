{ pkgs, ... }:

{
  home.packages = with pkgs; [
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
  ];

  home.sessionVariables = {
    ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    ZSH_CUSTOM = "$HOME/.config/oh-my-zsh/custom";
  };

  home.file.".config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh".source =
    "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";

  home.file.".config/oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh".source =
    "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh";

  home.file.".config/oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh".source =
    "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh";
}

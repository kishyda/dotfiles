{ pkgs, lib, ... }:

{
    home.file = {
      ".config/nvim".source = ../../nvim;
      ".config/yazi".source = ../../yazi;
      ".config/ghostty".source = ../../ghostty;
      ".config/zsh".source = ../../zsh;
      ".tmux.conf".source = ../../tmux/.tmux.conf;
      ".zshrc".source = ../../zsh/.zshrc;
      ".zshenv".source = ../../zsh/.zshenv;
      ".zprofile".source = ../../zsh/.zprofile;
      ".gitconfig".source = ../../git/.gitconfig;
    } // lib.optionalAttrs pkgs.stdenv.isDarwin {
      ".aerospace.toml".source = ../../aerospace/.aerospace.toml;
    };
}

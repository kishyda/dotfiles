{ pkgs, lib, ... }:

{
    home.packages =
      with pkgs;
      [
        curl wget gnupg openssh rsync unzip zip tree file which jq bat btop fzf direnv
        git gh delta lazygit git-lfs
        gnumake cmake gcc uv rustup go nodejs
        basedpyright cmake-language-server luaPackages.lua-lsp clang-tools go typescript-language-server nil
        tree-sitter
        neovim tmux yazi bitwarden-cli codex claude-code vscode
        nerd-fonts.iosevka
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [
        # Linux-specific packages can go here.
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        # Darwin-specific nix packages, if any.
      ];

    fonts.fontconfig.enable = true;
}

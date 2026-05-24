{ pkgs, lib, ... }:

{
    # This is internal compatibility configuration for home-manager, don't
    # change this without reading the home-manager release notes.
    home.stateVersion = "26.05";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        # Essentials
        curl wget gnupg openssh rsync unzip zip tree file which jq bat btop fzf direnv
            # Git stuff
            git gh delta lazygit git-lfs
            # Languages
            gnumake cmake gcc uv rustup go nodejs
            # LSPs
            basedpyright cmake-language-server luaPackages.lua-lsp clang-tools go typescript-language-server nil
            # Language Parsers
            tree-sitter
            # CLI Tools
            neovim tmux yazi bitwarden-cli codex claude-code
            # GUI Apps
            vscode
            # ghostty brave bitwarden-desktop

            # Fonts
            nerd-fonts.iosevka
    ];

    fonts.fontconfig.enable = true;

    home.file = {
        ".config/nvim".source = ../nvim;
        ".config/yazi".source = ../yazi;
        ".config/ghostty".source = ../ghostty;
        ".tmux.conf".source = ../tmux/.tmux.conf;
        ".zshrc".source = ../zsh/.zshrc;
        ".zshenv".source = ../zsh/.zshenv;
        ".zprofile".source = ../zsh/.zprofile;
        ".gitconfig".source = ../git/.gitconfig;
    } // lib.optionalAttrs pkgs.stdenv.isDarwin {
        ".aerospace.toml".source = ../aerospace/.aerospace.toml;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };

    programs.git.settings = {
        enable = true;
        userName = "Marcus Pyon";
        userEmail = "marcuspyon@gmail.com";
        ignores = [ ".DS_Store" ];
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
    };
}

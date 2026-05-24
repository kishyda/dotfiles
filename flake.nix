{
    description = "My system configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        mac-app-util = {
            url = "github:hraban/mac-app-util";
        };
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util }:
    let
        configuration = {pkgs, ... }: {

            system.primaryUser = "pyonpyon";

            nix.enable = false;

            security.pam.services.sudo_local.touchIdAuth = true;

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility. please read the changelog
            # before changing: `darwin-rebuild changelog`.
            system.stateVersion = 4;

            # The platform the configuration will be used on.
            # If you're on an Intel system, replace with "x86_64-darwin"
            nixpkgs.hostPlatform = "aarch64-darwin";

            nixpkgs.config.allowUnfree = true;

            # Declare the user that will be running `nix-darwin`.
            users.users.pyonpyon = {
                name = "pyonpyon";
                home = "/Users/pyonpyon";
            };

            # Create /etc/zshrc that loads the nix-darwin environment.
            programs.zsh.enable = true;

            homebrew = {
                enable = true;
                onActivation.cleanup = "uninstall";

                taps = [
                    "nikitabobko/tap"
                ];
                brews = [];
                casks = [
                    "aerospace" "bitwarden" "codex-app" "eqmac" "affinity" "anki" "linearmouse" "spotify" "basictex" "discord" "ghostty" # "nordvpn" 
                    "betterdisplay" "helium-browser" "obsidian"
                ];
            };

        };

        homeconfig = {pkgs, ...}: {
            # this is internal compatibility configuration 
            # for home-manager, don't change this!
            home.stateVersion = "26.05"; # Please read the comment before changing. 
            # Let home-manager install and manage itself.
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

            # Enable Fontconfig so the system finds the fonts
            fonts.fontconfig.enable = true;

            # Example of setting a dotfile config path
            home.file.".config/nvim".source = ./nvim/.config/nvim;
            home.file.".config/yazi".source = ./yazi/.config/yazi;
            home.file.".config/ghostty".source = ./ghostty/.config/ghostty;
            home.file.".tmux.conf".source = ./tmux/.tmux.conf;
            home.file.".zshrc".source = ./zsh/.zshrc;
            home.file.".zshenv".source = ./zsh/.zshenv;
            home.file.".zprofile".source = ./zsh/.zprofile;
            home.file.".gitconfig".source = ./git/.gitconfig;
            home.file.".aerospace.toml".source = ./aerospace/.aerospace.toml;

            home.sessionVariables = {
                EDITOR = "nvim";
            };

            # programs.zsh = {
            #     enable = true;
            #     shellAliases = {
            #         switch = "darwin-rebuild switch --flake ~/.config/nix";
            #     };
            # };
            programs.git.settings = {
                enable = true;
                userName = "Marcus Pyon";
                userEmail = "marcuspyon@gmail.com";
                ignores = [ ".DS_Store" ];
                init.defaultBranch = "main";
                push.autoSetupRemote = true;
            };
        };
    in
    {
        darwinConfigurations."pyonpyon" = nix-darwin.lib.darwinSystem {
            modules = [
                configuration
                mac-app-util.darwinModules.default
                home-manager.darwinModules.home-manager  {
                    home-manager.sharedModules = [
                        mac-app-util.homeManagerModules.default
                    ];
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.verbose = true;
                    home-manager.users.pyonpyon = homeconfig;
                }
            ];
        };
    };
}

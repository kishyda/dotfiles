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
        username = "pyonpyon";

        configuration = {pkgs, ... }: {

            system.primaryUser = username;

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
            users.users.${username} = {
                name = username;
                home = "/Users/${username}";
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

        mkHome = system: homeDirectory:
            home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                };

                modules = [
                    ./home.nix
                    {
                        home.username = username;
                        home.homeDirectory = homeDirectory;
                    }
                ];
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
                    home-manager.users.${username} = {
                        imports = [ ./home.nix ];
                        home.username = username;
                        home.homeDirectory = "/Users/${username}";
                    };
                }
            ];
        };

        homeConfigurations."${username}-linux" = mkHome "x86_64-linux" "/home/${username}";
    };
}

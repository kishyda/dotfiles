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
        username = "keeper";
        darwinSystem = "aarch64-darwin";
        linuxSystem = "x86_64-linux";
    in
    {
        darwinConfigurations."pyonpyon" = nix-darwin.lib.darwinSystem {
            system = darwinSystem;
            specialArgs = {
                inherit self username;
            };

            modules = [
                ./hosts/darwin
                mac-app-util.darwinModules.default
                home-manager.darwinModules.home-manager  {
                    home-manager.sharedModules = [
                        mac-app-util.homeManagerModules.default
                    ];
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.verbose = true;
                    home-manager.users.${username} = {
                        imports = [ ./home ];
                        home.username = username;
                        home.homeDirectory = "/Users/${username}";
                    };
                }
            ];
        };

        homeConfigurations."${username}-linux" = home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs {
                system = linuxSystem; 
                config.allowUnfree = true;
            };

            modules = [
                ./home
                ./hosts/linux
                {
                    home.username = username;
                    home.homeDirectory = "/home/${username}";
                }
            ];
        };
    };
}

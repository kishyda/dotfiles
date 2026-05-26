{ self, username, ... }:

{
    system.primaryUser = username;

    nix.enable = false;

    security.pam.services.sudo_local.touchIdAuth = true;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility. please read the changelog
    # before changing: `darwin-rebuild changelog`.
    system.stateVersion = 4;

    # If you're on an Intel Mac, replace this with "x86_64-darwin".
    nixpkgs.hostPlatform = "aarch64-darwin";

    nixpkgs.config.allowUnfree = true;

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
            "aerospace"
            "bitwarden"
            "codex-app"
            "eqmac"
            "affinity"
            "anki"
            "linearmouse"
            "spotify"
            "basictex"
            "discord"
            "ghostty"
            "betterdisplay"
            "helium-browser"
            "obsidian"
        ];
    };
}

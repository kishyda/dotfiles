{ ... }:

{
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;

    imports = [
      ./packages.nix
      ./dotfiles.nix
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.git = {
      enable = true;
      ignores = [ ".DS_Store" ];
      settings = {
        user = {
          name = "Marcus Pyon";
          email = "marcuspyon@gmail.com";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };
}

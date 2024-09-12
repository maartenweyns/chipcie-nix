{pkgs, ...}:

{
    home.username = "icpctools";
    home.homeDirectory = "/home/icpctools";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;

    home.file = {
        "test" = {
            enable = "true";
        };
    }
}
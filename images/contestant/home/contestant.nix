{ ... }:

{
  home.file = {
    "wallpaper" = {
      source = "./wallpaper.jpg";
      target = "./.background-image";
    };
  };

  home.username = "contestant";
  home.homeDirectory = "/home/contestant";
  home.stateVersion = "23.11";
  programs.home-manager.enable = false;
}

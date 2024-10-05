{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = true;
      xfce.enable = true;
    };
    displayManager.lightdm.enable = true;
  };
}

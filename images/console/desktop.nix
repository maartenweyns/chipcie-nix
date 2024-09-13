{ lib, pkgs, ...}:

{
    services.xserver = {
        enable = true;
        desktopManager = {
            xterm.enable = false;
            xfce.enable = true;
        };
    };

    services.displayManager.defaultSession = "xfce";

    # Audio requirement for xfce
    nixpkgs.config.pulseaudio = true
}

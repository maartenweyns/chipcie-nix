{ lib, pkgs, ...}:

{
    boot.kernelParams = [ "console=tty0" ];
    nixpkgs.config.allowUnfree = true;

    # Add experimental flakes support
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable audio support through pulseaudio
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;
}
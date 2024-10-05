{ lib, pkgs, ... }:

{
  boot.kernelParams = [ "console=tty0" "consoleblank=0" "biosdevname=0" "net.ifnames=0" ];
  nixpkgs.config.allowUnfree = true;

  # Add experimental flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.journald.console = "tty1";

  # Enable audio support through pulseaudio
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;
}

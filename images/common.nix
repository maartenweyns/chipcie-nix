{ lib, pkgs, ... }:

{
  boot.kernelParams = [ "console=tty0" "consoleblank=0" "biosdevname=0" "net.ifnames=0" ];
  nixpkgs.config.allowUnfree = true;

  # Add experimental flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.journald.console = "tty1";
  services.journald.forwardToSyslog = false;
  services.journald.extraConfig = ''
    ForwardToKMsg=no
    ForwardToConsole=yes
    ForwardToWall=no
    TTYPath=/dev/tty1
    Storage=volatile
  '';

  systemd.extraConfig = ''
    ShowStatus=no
  '';

  time.timeZone = "Europe/Amsterdam";

  # Enable audio support through pulseaudio
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;
}

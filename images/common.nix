{ lib, pkgs, ...}:

{
    boot.kernelParams = [ "console=tty0" ];
    nixpkgs.config.allowUnfree = true;
}
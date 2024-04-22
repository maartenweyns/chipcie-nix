{ lib, pkgs, ...}:

{
    boot.kernelParams = [ "console=tty0" ];
}
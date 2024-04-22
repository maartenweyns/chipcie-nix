{ lib, pkgs, ...}:

{
    networking = {
        wireless.enable = false;
        useDHCP = true;
        hostname = "chipcie-console";
    };
}
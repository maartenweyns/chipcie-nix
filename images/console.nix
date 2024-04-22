{ lib, pkgs, ...}:

{
    imports = [
        ./console/base.nix
        ./console/gnome.nix
    ];
}
{ lib, pkgs, ...}:

{
    imports = [
        ./console/packages.nix
        ./console/base.nix
        ./console/gnome.nix
        ./console/docker.nix
        ./console/home.nix
    ];
}
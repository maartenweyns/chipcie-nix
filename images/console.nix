{ lib, pkgs, ... }:

{
  imports = [
    ./console/packages.nix
    ./console/base.nix
    ./console/desktop.nix
    ./console/docker.nix
    ./console/home.nix
  ];
}

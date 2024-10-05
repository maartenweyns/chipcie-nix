{ lib, pkgs, ... }:

{
  imports = [
    ./admintools.nix
    ./base.nix
    ./gui.nix
    ./home.nix
  ];
}

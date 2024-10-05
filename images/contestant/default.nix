{ lib, pkgs, ... }:

{
  imports = [
    ./admintools.nix
    ./base.nix
    ./browser.nix
    ./gui.nix
    ./home.nix
  ];
}

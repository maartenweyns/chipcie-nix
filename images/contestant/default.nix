{ lib, pkgs, ... }:

{
  imports = [
    ./admintools.nix
    ./base.nix
    ./browser.nix
    ./devtools.nix
    ./gui.nix
    ./home.nix
  ];
}

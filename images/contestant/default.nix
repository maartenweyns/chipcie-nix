{ lib, pkgs, ... }:

{
  imports = [
    ./admintools.nix
    ./base.nix
    ./browser.nix
    ./compilers.nix
    ./devtools.nix
    ./gui.nix
    ./home.nix
    ./icpc.nix
    ./monitoring.nix
    ./printer.nix
    ./scripts.nix
    ./vmtouch.nix
  ];
}

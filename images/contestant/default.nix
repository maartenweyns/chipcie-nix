{ lib, pkgs, ... }:

{
  imports = [
    ./admintools.nix
    ./base.nix
    ./browser.nix
    ./compilers.nix
    # ./devtools.nix
    ./gui.nix
    ./home.nix
    ./monitoring.nix
    ./scripts.nix
  ];
}

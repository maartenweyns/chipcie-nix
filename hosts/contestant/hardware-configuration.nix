{ config, lib, pkgs, modulesPath }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];


}

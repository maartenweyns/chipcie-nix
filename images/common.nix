{ lib, pkgs, ...}:

{
    # EFI booting
    isoImage.makeEfiBootable = true;

    # USB booting
    isoImage.makeUsbBootable = true;

    
}
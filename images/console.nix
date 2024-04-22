{ lib, pkgs, ...}:

{
    imports = [
        ./console/base.nix
        ./console/gnome.nix
    ];

    isoImage.volumeID = lib.mkForce "chipcie-console";
    isoImage.isoName = lib.mkForce "chipcie-console.iso";
    # Use zstd instead of xz for compressing the liveUSB image, it's 6x faster and 15% bigger.
    isoImage.squashfsCompression = "zstd -Xcompression-level 6";
}
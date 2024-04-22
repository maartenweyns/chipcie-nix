# CHipCie NixOS Configurations

This repo contains the NixOS configuration for CHipCie images, used in prorgramming contests such as FPC, DAPC and NWERC.

This configuration is kickstarted by [this](https://discourse.nixos.org/t/creating-a-nixos-live-cd-for-whole-system/35638/2) post on the Nix community forum.

## Building the images

Building the console image is as easy as running the following command:

```bash
nix build .#console
```

After a succesful build, the image can be found in `result/nixos.img`.

## Testing the images locally

Currently, the easiest way is to start a `qemu` VM with the generated image. Use the following command to do so:

```bash
qemu-system-x86_64 -drive file=nixos.img,index=0,media=disk,format=raw -m 4G -smp 4 -enable-kvm -vga virtio -display default
```
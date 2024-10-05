default:
  @just --list

run:
  qemu-system-x86_64 -drive file=nixos.img,index=0,media=disk,format=raw -m 4G -smp 4 -enable-kvm -vga virtio -display default

build:
  nix build .#console
  cp result/nixos.img nixos.img
  chmod +rw nixos.img

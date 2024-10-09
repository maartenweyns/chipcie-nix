{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    vmtouch
  ];

  systemd.services.warm-fs-cache = {
    description = "Warm up file system cache";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /usr/bin/nice -n 19 /usr/bin/find / -path /proc -prune -o -path /sys -prune -o -print
        /usr/bin/nice -n 19 /icpc/scripts/vmtouch.sh
      '';
    };
  };
}

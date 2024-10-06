{ pkgs, lib, ... }:
rec {
  systemd.tmpfiles.rules = [
    "d /icpc 0755 icpcadmin icpcadmin -"
    "C+ /icpc/scripts 0755 icpcadmin icpcadmin - ${environment.etc.icpc-scripts.source}"
    "Z /icpc/scripts 755 icpcadmin icpcadmin -"
  ];

  environment.etc = {
    icpc-scripts = {
      source = ./files/scripts;
      target = "icpc/scripts";
    };


  };

  environment.variables.PATH = "/icpc/scripts/bin:$PATH";

  environment.systemPackages = with pkgs; [
    python311Full
    python311Packages.requests
    python311Packages.magic
  ];
}

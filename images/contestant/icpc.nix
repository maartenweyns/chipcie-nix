{ pkgs, lib, ... }:
let

  on_boot_text = builtins.readFile ../files/scripts/on_boot.sh;
  on_boot = pkgs.writeShellScriptBin "on-boot" on_boot_text;
in

rec {
  # systemd.tmpfiles.rules = [
  # "C+ /icpc/wallpaper.png - - - - ${environment.etc.wallpaper.source}"
  # ];

  environment.etc = {
    wallpaper = {
      source = ./files/wallpaper.png;
      target = "wallpaper.png";
    };

    contestant-home = {
      source = ./files/home_dirs/contestant;
      target = "skel";
    };
  };

  environment.systemPackages = with pkgs; [
    noto-fonts-color-emoji
    imagemagick
    git
    ntp
    zip
    jq
    wget
  ];

  security.polkit.enable = true;
  # TODO Add polkit rules

  services.logind.extraConfig = ''
    KillOnlyUsers=contestant
  '';

  #TODO delete icpc workspaces
  #TODO add icpcadmin home template


  systemd.tmpfiles.rules = [
    "d /icpc 0755 icpcadmin icpcadmin -"
    # "C+ /icpc/scripts 0755 icpcadmin icpcadmin - ${environment.etc.icpc-scripts.source}"
    # "C+ /icpc/scripts/bin/disable-turboboost_ht 0755 icpcadmin icpcadmin - ${environment.etc.disable-turboboost.source}"
    # "C+ /icpc/scripts/bin/submit 0755 icpcadmin icpcadmin - ${environment.etc.submit-client.source}"
    "Z /icpc/scripts 755 icpcadmin icpcadmin -"
    "f /icpc/netrc 644 icpcadmin icpcadmin -"
  ];

  environment.etc =
    {
      on_boot = {
        source = ./files/scripts/on_boot.sh;
        target = "icpc/scripts/on_boot.sh";
        mode = "0755";
      };

      self_test = {
        source = ./files/scripts/self_test;
        target = "icpc/scripts/self_test";
        mode = "0755";
      };

      checkFirewall = {
        source = ./files/scripts/checkFirewall.sh;
        target = "icpc/scripts/checkFirewall.sh";
        mode = "0755";
      };

      check_battery = {
        source = ./files/scripts/check_battery.sh;
        target = "icpc/scripts/check_battery.sh";
        mode = "0755";
      };

      deleteUser = {
        source = ./files/scripts/deleteUser.sh;
        target = "icpc/scripts/deleteUser.sh";
        mode = "0755";
      };

      desktop_checksums = {
        source = ./files/scripts/desktop_checksums.sh;
        target = "icpc/scripts/desktop_checksums.sh";
        mode = "0755";
      };

      disableFirewall = {
        source = ./files/scripts/disableFirewall.sh;
        target = "icpc/scripts/disableFirewall.sh";
        mode = "0755";
      };

      enableFirewall = {
        source = ./files/scripts/enableFirewall.sh;
        target = "icpc/scripts/enableFirewall.sh";
        mode = "0755";
      };

      expandPartition = {
        source = ./files/scripts/expandPartition.sh;
        target = "icpc/scripts/expandPartition.sh";
        mode = "0755";
      };



      disable-turboboost = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/DOMjudge/domjudge-scripts/main/provision-contest/disable-turboboost_ht";
          sha256 = "1signld4w4sp0z8vypw1kcqi5442d2kwwa62syicd6hyi9rf7kkj";
        };
        target = "disable-turboboost_ht";
      };
      submit-client = {
        source = pkgs.fetchurl {
          url = "https://github.com/DOMjudge/domjudge/raw/main/submit/submit";
          sha256 = "112pnchxl8x01prxam88928m1cabl1yjipmdki3747diq9k2nihb";
        };
      };
    };


  environment.variables.PATH = "/icpc/scripts/bin:$PATH";

  systemd.services.firstboot = {
    description = "Initial self test";
    enable = true;
    before = [ "display-manager.service" ];
    wants = [ "network-online.target" "printer.target" ];
    after = [ "network-online.target" "cups.service" "getty@tty2.service" ];
    wantedBy = [ "graphical.target" "multi-user.target" ];

    environment = lib.mkForce {
      PATH = "/run/current-system/sw/bin";
    };

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      TimeoutSec = 0;
      TTYReset = "yes";
      TTYVHangup = "yes";
      TTYPath = "/dev/tty5";
      TTYVTDisallocate = "yes";
      StandardInput = "tty";
      StandardOutput = "tty";
      # ExecStart = "/usr/bin/env bash -c '/usr/bin/env chvt 2; /icpc/scripts/on_boot.sh'";
      # ExecStart = "/bin/sh -c '/etc/icpc/scripts/on_boot.sh'";
      ExecStart = "/run/current-system/sw/bin/bash -c '/run/current-system/sw/bin/chvt 5; ${on_boot}/bin/on-boot'";
    };
  };
  # environment.variables.SUBMITBASEURL = submitbaseurl;

  # environment.systemPackages = with pkgs; [
  # python312
  # python312Packages.requests
  # python312Packages.magic
  # ];
}

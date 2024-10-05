{ lib, pkgs, ... }:

{
  networking = {
    wireless.enable = false;
    useDHCP = lib.mkForce true;
    hostName = "chipcie-contestant";
  };

  users = {
    mutableUsers = true;

    groups = {
      "contestant" = { };
      "icpcadmin" = { };
    };

    users = {
      "contestant" = {
        group = "contestant";
        isNormalUser = true;
        hashedPassword = "$y$j9T$nCW2iFExGkmR9WULMCX110$2Uau1ZvrtogyXplyRfScxPqQTdCf876YhEAtY6Cc3s/";
        # extraGroups = [ "teams" "lpadmin" ];
      };
      "icpcadmin" = {
        group = "icpcadmin";
        isNormalUser = true;
        hashedPassword = "$y$j9T$l1SabA/8/ZVLzqELOwFe7.$BpKkbTYtxX45kUHTCI33uBnwHfM.AMuOjeebag9hvP1";
        extraGroups = [ "wheel" "audio" ];
      };
    };
  };

  # Enable SSH
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;

  # Disable sudo password requirement
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
}

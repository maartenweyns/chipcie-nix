{ pkgs, lib, ... }:
{
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = true;
      xfce.enable = true;
    };
    displayManager = {
      lightdm = {
        enable = true;
        autoLogin.timeout = 0;
        greeter.enable = true;
      };

    };
  };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "contestant";
    };
  };
}

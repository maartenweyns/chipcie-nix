{ lib, pkgs, ...}:

{
    networking = {
        wireless.enable = false;
        useDHCP = true;
        hostname = "chipcie-console";
    };

    users = {
        mutableUsers = true;
        users.users = {
            "icpcadmin" = {
                isNormalUser = true;
                hashedPassword = "$y$j9T$l1SabA/8/ZVLzqELOwFe7.$BpKkbTYtxX45kUHTCI33uBnwHfM.AMuOjeebag9hvP1";
                extraGroups = [ "wheel" ];
            }
        }
    }
}
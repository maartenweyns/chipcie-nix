{ lib, pkgs, ...}:

{
    networking = {
        wireless.enable = false;
        useDHCP = true;
        hostName = "chipcie-console";
    };

    users = {
        mutableUsers = true;
        users.users = {
            "icpcadmin" = {
                isNormalUser = true;
                hashedPassword = "$y$j9T$l1SabA/8/ZVLzqELOwFe7.$BpKkbTYtxX45kUHTCI33uBnwHfM.AMuOjeebag9hvP1";
                extraGroups = [ "wheel" ];
            };
            "icpctools" = {
                isNormalUser = true;
                hashedPassword = "$y$j9T$WKPftiKUOrUjjvxzUS76o/$tS8nd3ja5WZK.AAmFjiF87ihOWrDmjIaX61Bf1J7H7B";
            };
        };
    };

    # Disable sudo password requirement
    security.sudo.wheelNeedsPassword = false;
}
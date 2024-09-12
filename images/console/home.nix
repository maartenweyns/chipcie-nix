{ config, pkgs, inputs, lib, ... }:

let
    # Collect all created normal users
    userNames = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (user: user.isNormalUser) users.users);
in {
    # import the HM system module *once*
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    # configure HM
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # create all the individual HM users if and only if they have an "entrypoint" file under `./home`
    home-manager.users = lib.mkMerge 
        (builtins.map (user:
            lib.mkIf (builtins.pathExists ./home/${user}.nix) {$user.imports = [ ./home/${user}.nix ];}
        ) userNames);
}
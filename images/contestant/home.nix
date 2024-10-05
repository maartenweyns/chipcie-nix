{ ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users = {
    "contestant" = {
      imports = [ ];
    };

    "icpcadmin" = {
      imports = [ ];
    };
  };
}

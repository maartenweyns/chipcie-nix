{
  inputs = {
    # Use unstable for flakes
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Add home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use nixos generators for generating an iso
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, ... }: {
    ## nix build .#console
    packages.x86_64-linux.console = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "raw";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./images/common.nix
        ./images/console.nix
        {
          system.stateVersion = "23.11";
        }
      ];
    };
  };
}

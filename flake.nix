{
    inputs = {
        # Use unstable for flakes
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        # Use nixos generators for generating an iso
        nixos-generators.url = "github:nix-community/nixos-generators";
        nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nixpkgs, flake-utils, ... }: {
        ## nix build .#iso
        ## nixcfg --build-iso && nixcfg --burn-iso 00000111112222333
        packages.x86_64-linux.iso = inputs.nixos-generators.nixosGenerate {
            system = "x86_64-linux";
            format = "iso";
            specialArgs = {
                inherit inputs;
            };
            modules = [
                # Provide minimal NixOS config
                "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
                ./images/console.nix
                {
                    system.stateVersion = "23.11";
                }
            ];
        };
    };
}
{ lib, pkgs, ...}:

{
    environment.systemPackages = with pkgs; [
        jq
        htop
        curl
        wget
        unzip
        docker
        firefox
        git
        vscode
    ];
}
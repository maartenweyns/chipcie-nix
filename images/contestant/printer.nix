{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    cups
    gnomeExtensions.printers
    enscript
    cups-pdf-to-pdf
    python312Packages.fpdf
    python312Packages.pypdf2
  ];

  services.printing.enable = true;

  environment.etc = {
    "papersize" = {
      text = ''
        A4

      '';
      mode = "0644";
    };
  };
}

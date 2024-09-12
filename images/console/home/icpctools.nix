{lib, pkgs, ...}:

let
    toolsVersion = "2.5.1056";
    zipFiles = [
	{
	    name = "presentations-${toolsVersion}.zip";
            sha256 = "6d014f52e4b97c1b53acf7e028a53a65324d41bc67e5972241de606f183293d1";
	    extractTo = "tools/presentations-${toolsVersion}";
        }
        {
	    name = "presentationAdmin-${toolsVersion}.zip";
            sha256 = "87711039cce5f6542ae31615b786c6638257072019e5201f9a310a0494450a31";
	    extractTo = "tools/presentationAdmin-${toolsVersion}";
        }
        {
	    name = "resolver-${toolsVersion}.zip";
	    sha256 = "bf96730983b3f42f25e753fb12c1dd227217b61a3ab20d042a158efa41af4f76";
	    extractTo = "tools/resolver-${toolsVersion}";
        }
    ];
    
    generateFiles = zip: {
        "Downloads/${zip.name}".source = builtins.fetchurl {
      	    url = "https://github.com/icpctools/icpctools/releases/download/v${toolsVersion}/${zip.name}";
      	    sha256 = zip.sha256;
        };
    };
    
    filesList = map generateFiles zipFiles;
    files = lib.mkMerge filesList;

    extractZip = zip: ''
        mkdir -p ~/${zip.extractTo}
	unzip -o ~/Downloads/${zip.name} -d ${zip.extractTo}
    '';
in {
    home.username = "icpctools";
    home.homeDirectory = "/home/icpctools";
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
    
    home.file = files;

    home.packages = with pkgs; [
        unzip
    ];

    home.activation.extractZips = lib.hm.dag.entryAfter ["writeBoundary"] ''
	${lib.concatStringsSep "\n" (map extractZip zipFiles)}
    '';
}

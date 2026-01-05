{pkgs, ...}: let
  name = "firefox-with-context";
in
  pkgs.stdenv.mkDerivation (finalAttrs: {
    inherit name;
    pname = name;

    src = pkgs.writeShellApplication {
      inherit name;
      text = builtins.readFile ./firefox-with-context;
    };

    nativeBuildInputs = [pkgs.copyDesktopItems];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      cp ${finalAttrs.src}/bin/${name} $out/bin/

      runHook postInstall
    '';

    desktopItems = [
      (pkgs.makeDesktopItem
        {
          inherit name;
          desktopName = "Firefox with context";
          noDisplay = true;
          exec = "${name} %u";
          comment = "Open the given URL in a browser-profile based on context";

          mimeTypes = [
            "x-scheme-handler/http"
            "x-scheme-handler/https"
          ];
        })
    ];
  })

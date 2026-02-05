{pkgs, ...}: let
  defaultApplicationPackages = with pkgs; [
    nautilus # file viewer
    loupe # image viewer
    kdePackages.okular # pdf viewer
    # kdePackages.ark # Archives
    vlc # Video player
  ];
in {
  home.packages = with pkgs;
    [
      # Simple browsers for HTML
      qutebrowser
      harbor.firefox-with-context # Open URLs in different browser profiles based on context
    ]
    ++ defaultApplicationPackages;

  xdg.mimeApps = {
    enable = true;

    inherit defaultApplicationPackages;

    # Only want to use qute for HTML files, not URLs
    defaultApplications = {
      "text/html" = "qutebrowser";
      "x-scheme-handler/http" = "firefox-with-context";
      "x-scheme-handler/https" = "firefox-with-context";
    };
  };
}

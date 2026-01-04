{pkgs, ...}: {
  home.packages = with pkgs; [
    # Simple browsers for HTML
    qutebrowser
    pkgs._elements.firefox-with-context # Open URLs in different browser profiles based on context
  ];

  xdg.mimeApps = {
    enable = true;

    defaultApplicationPackages = with pkgs; [
      kdePackages.gwenview # image viewer
      kdePackages.okular # pdf viewer
      kdePackages.ark # Archives
      vlc # Video player
    ];

    # Only want to use qute for HTML files, not URLs
    defaultApplications = {
      "text/html" = "qutebrowser";
      "x-scheme-handler/http" = "firefox-with-context";
      "x-scheme/handler/https" = "firefox-with-context";
    };
  };
}

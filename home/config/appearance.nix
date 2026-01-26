{
  lib,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };

    # cursorTheme = {
    #   name = "BreezeX-RosePineDawn-Linux";
    #   package = pkgs.rose-pine-cursor;
    #   size = 32;
    # };
  };

  qt = {
    enable = true;
    style.name = "adwaita";
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
    # GTK_THEME = "rose-pine";
    XCURSOR_SIZE = "32";
  };
}

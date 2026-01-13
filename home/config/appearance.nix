{
  lib,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;

    iconTheme.name = "breeze-dark";
    # cursorTheme = {
    #   name = "BreezeX-RosePineDawn-Linux";
    #   package = pkgs.rose-pine-cursor;
    #   size = 32;
    # };
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = "1";
    GTK_THEME = "rose-pine";
    XCURSOR_SIZE = "32";
  };
}

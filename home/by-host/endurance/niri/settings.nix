{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings = {
    prefer-no-csd = true;

    # debug.honor-xdg-activation-with-invalid-serial = true;

    layout = {
      always-center-single-column = true;
      background-color = "transparent";
      focus-ring.enable = true;
      gaps = 12; # 24 before
      shadow.enable = true;
    };

    overview = {
      workspace-shadow.enable = false;
    };

    # workspaces = {
    #   "streaming" = { };
    # };

    input = {
      # disable-power-key-handling = true;
      keyboard.xkb = {
        layout = "us";
        variant = "intl";
      };
    };

    outputs = {
      "DP-3" = {
        position.x = 3840;
        position.y = -430;
        transform.rotation = 90;
      };
      "HDMI-A-1" = {
        position.x = 0;
        position.y = 0;
        focus-at-startup = true;
      };
    };

    environment = {
      MOZ_ENABLE_WAYLAND = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
    };
  };
}

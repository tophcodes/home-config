{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;

  sddmTheme = pkgs.sddm-astronaut.override {
    embeddedTheme = "japanese_aesthetic";
    themeConfig = {
    };
  };
in {
  imports = [
    #inputs.niri.nixosModules.niri
  ];

  config = mkIf config.bosun.profiles.graphical.enable {
    environment.systemPackages = with pkgs; [
      wayland-utils
      wl-clipboard
      libsForQt5.qtstyleplugin-kvantum
      xwayland-satellite
      nautilus
      sddmTheme
      kdePackages.qtmultimedia # required for our sddm theme
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri; # TODO: Use input niri pkgs/overlay!
    };

    services = {
      xserver = {
        enable = true;
        displayManager.setupCommands = ''
          /run/current-system/sw/bin/xrandr --output HDMI-A-1 --primary
          /run/current-system/sw/bin/xrandr --output DP-3 --right-of HDMI-A-1 --rotate left
        '';
      };

      displayManager = {
        defaultSession = "niri";

        sddm = let
          theme = "sddm-astronaut-theme";
        in {
          enable = true;
          package = pkgs.kdePackages.sddm;

          # wayland.enable = true;

          inherit theme;
          extraPackages = [sddmTheme];
          settings.Theme.Current = theme;
        };
      };
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "gtk";

      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    security.polkit.enable = true;
  };
}

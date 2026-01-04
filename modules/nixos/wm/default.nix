{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.elements.wm;
in {
  options.elements = {
    wm = {
      enable = mkEnableOption "Enable window manager configuration";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # kdePackages.discover
      # kdePackages.kclock
      # kdePackages.kcharselect
      # kdePackages.kolourpaint
      # kdePackages.ksystemlog
      wayland-utils
      wl-clipboard
      libsForQt5.qtstyleplugin-kvantum
      xwayland-satellite
      nautilus # xdg-gnome needs this but we don't use gnome???
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # niri-flake.cache.enable = false;

    services.xserver = {
      enable = true;
    };

    # TODO: Switch this to Niri!
    services.desktopManager.plasma6.enable = true;
    services.displayManager = {
      defaultSession = "niri";

      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    xdg.portal = with pkgs; {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = [xdg-desktop-portal-gnome xdg-desktop-portal-gtk];
      #E configPackages = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = "gtk";
    };

    security.polkit.enable = true;
  };
}

{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.default
  ];

  config = {
    environment.systemPackages = with pkgs; [
      wayland-utils
      wl-clipboard
      libsForQt5.qtstyleplugin-kvantum
      xwayland-satellite
      nautilus
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri; # TODO: Use input niri pkgs/overlay!
    };

    services = {
      xserver.enable = true;

      displayManager = {
        defaultSession = "niri";

        sddm = {
          enable = true;
          wayland.enable = true;
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
  };
}

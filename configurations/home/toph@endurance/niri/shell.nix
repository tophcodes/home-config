{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs = {
    noctalia-shell = {
      enable = true;
      systemd.enable = true;

      settings = {
        general.radiusRatio = 0.5;

        location = {
          name = "Blankenbach, Germany";
          showWeekNumberInCalendar = true;
        };

        bar = {
          position = "left";
          density = "comfortable";
          floating = true;
          marginHorizontal = 0.73;
          marginVertical = 0.73;

          widgets = {
            left = [
              {id = "ControlCenter";}
              {id = "SystemMonitor";}
            ];

            center = [
              # {id = "MediaMini";}
              {id = "Workspace";}
            ];

            right = [
              {id = "Tray";}
              {id = "ScreenRecorder";}
              {id = "Volume";}
              {id = "NotificationHistory";}
              {id = "Clock";}
            ];
          };
        };

        wallpaper = {
          enabled = true;
          overviewEnabled = false;
          directory = "/nix/harbor/desktops/configurations/home/toph@endurance/wallpapers";
          recursiveSearch = false;
          randomEnabled = true;
        };
      };
    };

    quickshell.enable = true;
  };
}

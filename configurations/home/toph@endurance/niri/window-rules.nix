{
  config,
  pkgs,
  ...
}: let
  borders = bl: br: tl: tr: {
    bottom-left = bl;
    bottom-right = br;
    top-left = tl;
    top-right = tr;
  };

  radius = 12.0;
  rounded = borders radius radius radius radius;
  rounded-left = borders radius 0.0 0.0 radius;
  rounded-right = borders 0.0 radius radius 0.0;
in {
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [{namespace = "^noctalia-wallpaper*";}];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = rounded-left;
      }
      {
        matches = [{is-focused = true;}];
        focus-ring.width = 2;
      }
      {
        matches = [
          {app-id = "1password";}
          {app-id = "thunderbird";}
        ];

        block-out-from = "screencast";
      }
      {
        matches = [{title = "fastfetch";}];
        open-floating = true;
        opacity = 1.0;

        min-width = 400; # 115 x 26 columns
        max-width = 400;
        min-height = 400;
        max-height = 400;
      }
      {
        matches = [{title = "ld.toph.so";}];
        default-column-width = {proportion = 0.75;};
        open-floating = true;
        opacity = 1.0;

        min-width = 500;
        max-width = 1000;
        min-height = 500;
        max-height = 800;

        block-out-from = "screencast";
      }
      {
        matches = [{app-id = "kitty";}];
        opacity = 0.97;
      }
      {
        matches = [
          {app-id = "org.zealdocs.zeal";}
          {app-id = "speedcrunch";}
        ];
        open-floating = true;
      }
    ];
  };
}

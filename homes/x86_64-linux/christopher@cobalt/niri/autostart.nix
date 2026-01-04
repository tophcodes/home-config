{
  lib,
  pkgs,
  ...
}: {
  programs.niri.settings.spawn-at-startup = with lib._elements; [
    # {argv = ["awww-daemon"];}
    # {argv = ["awww" "img" "${fixture "wallpapers/cat-vibes.webp"}"];}

    {argv = ["kitty"];}
  ];
}

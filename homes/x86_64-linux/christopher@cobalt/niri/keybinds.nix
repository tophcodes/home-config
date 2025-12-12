{
  lib,
  config,
  pkgs,
  ...
}: let
in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
  in {
    "Mod+f".action = fullscreen-window;
  };
}

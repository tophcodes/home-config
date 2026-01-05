{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  imports = mkIf config.bosun.profiles.graphical.enabled [
    ./wm.nix
    ./audio.nix
  ];
}

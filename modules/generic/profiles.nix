{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.bosun.profiles = {
    graphical.enable = mkEnableOption "Graphical interface";
    headless.enable = mkEnableOption "Headless";
    workstation.enable = mkEnableOption "Workstation";
    server.enable = mkEnableOption "Server";
  };
}

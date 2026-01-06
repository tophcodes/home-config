{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.bosun.profiles = {
    graphical.enable = mkEnableOption "Graphical interface";
    headless.enable = mkEnableOption "Headless";
    docker.enable = mkEnableOption "Docker usage";
    work.enable = mkEnableOption "Work setup";
  };
}

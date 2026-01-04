{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.homeModules.stylix];

  home.packages = with pkgs; [
    # themes firefox with wallpaper theme
    pywalfox-native
  ];

  stylix = {
    enable = true;
    autoEnable = true;

    # TODO: Figure out a way for automatic dark-/light-mode switching
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";

    targets.firefox.profileNames = ["default" "work" "streaming"];

    cursor = {
      package = pkgs.rose-pine-cursor;
      # name = "Rosé Pine Dawn";
      name = "BreezeX-RosePineDawn-Linux";
      size = 32;
    };
  };
}

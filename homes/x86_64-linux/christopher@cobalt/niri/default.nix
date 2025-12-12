{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
  ];

  programs.niri.package = pkgs.niri;

  home.packages = with pkgs; [
    fuzzel
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];
}

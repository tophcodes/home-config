{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri

    ./settings.nix
    ./window-rules.nix
    ./keybinds.nix
    ./autostart.nix
    ./shell.nix
  ];

  home.packages = with pkgs; [
    fuzzel
  ];
}

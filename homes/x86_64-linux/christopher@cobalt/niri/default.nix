{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./window-rules.nix
    ./keybinds.nix
    ./autostart.nix
    ./shell.nix
  ];

  home.packages = with pkgs; [
    fuzzel
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];
}

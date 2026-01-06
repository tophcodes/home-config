{...}: {
  imports = [
    ./secrets.nix
    ./common
    ./gui
  ];

  # no need to ever change this
  home.stateVersion = "25.11";
}

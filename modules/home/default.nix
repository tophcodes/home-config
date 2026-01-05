{...}: {
  imports = [
    ./secrets.nix
  ];

  # no need to ever change this
  home.stateVersion = "25.11";
}

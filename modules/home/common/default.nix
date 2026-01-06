{...}: {
  imports = [
    ./helix
    ./terminal
  ];

  home = {
    stateVersion = "25.11";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}

{...}: {
  programs.firefox = {
    enable = true;

    profiles = {
      "default".id = 0;
      "work".id = 1;
      "prune".id = 3;
    };
  };

  # profile-sync-daemon
  services.psd = {
    enable = true;
    resyncTimer = "10m";
  };
}

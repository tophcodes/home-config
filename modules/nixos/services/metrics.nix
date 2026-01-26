{...}: {
  services = {
    tailscale = {
      enable = true;
    };

    prometheus.exporters = {
      node = {
        enable = true;
        port = 9000;
      };
      # tailscale = {
      #   enable = true;
      #   port = 9001;
      # };
    };
  };
}

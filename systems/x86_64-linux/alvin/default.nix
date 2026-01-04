{...}: {
  imports = [
    ./hardware.nix
    ./traefik.nix
    ./radicle.nix
    ./static.nix
    ./victoria.nix
    ./solid.nix
    ./oxigraph.nix
    ./matrix.nix
  ];

  elements = {
    hostname = "alvin";

    secrets = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzji6twM8/QdDgFGSUKNmvCm/kEfFMYWZdmgRBbs5Nc";
      needs.radiclePrivateKey.rekeyFile = "radicle.age";
      needs.radiclePublicKey.rekeyFile = "radicle.pub.age";
      needs.victoriametricsPasswordFile.rekeyFile = "victoria-password.age";
    };
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking = {
    enableIPv6 = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [22 80 443];
    };
    domain = "contaboserver.net";

    defaultGateway = "62.169.24.1";
    nameservers = ["8.8.8.8" "8.8.4.4"];
    interfaces.ens18 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "62.169.31.37";
          prefixLength = 21;
        }
      ];
    };
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+XpUv6qTqJ7NmYDz9hjvobDBJY9NN3S0TjXD0q2kt2 christopher@cobalt"];

  system.stateVersion = "23.11";
}

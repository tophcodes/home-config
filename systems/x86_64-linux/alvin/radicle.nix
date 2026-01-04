{config, ...}: let
  nodeAddress = "seed.toph.so";
  radConfig = config.services.radicle;

  followed = [
    "z6Mkm1WGVW5Zr6Ubn2aJU7S26Knjum3Y3iSC39zJ8EojRkt9" # toph
  ];
  seedRepositories = [
    "rad:zBNXLtTqUu9LBZHCPFShAeXnp5Gz" # radicle-ci
    "rad:z254T5p17bdFPmzfDojsdjo4HjpoZ" # radicle-infra
  ];
in {
  services = {
    radicle = {
      enable = true;

      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEihs1RjZ52Vcy+NJuFhiRbEp5SfwND3b3oSjD2V0HTG";
      privateKeyFile = config.age.secrets.radiclePrivateKey.path;

      httpd = {
        enable = true;
        nginx.serverName = nodeAddress;
      };

      # Seeding node
      node = {
        listenAddress = "[::0]";
        openFirewall = true;
      };

      settings = {
        preferredSeeds = [
        ];
        node = {
          alias = nodeAddress;
          # externalAddresses = ["${nodeAddress}:${builtins.toString radConfig.node.listenPort}"];

          follow = followed;
          seeds = seedRepositories;

          seedingPolicy = {
            default = "allow";
            scope = "all";
          };
        };
        web = {
          description = ''
            Hi there! I'm toph, a passionate federated and semantic web developer.
            This is my main Radicle seed node that I also use to showcase my projects.

            I'll try to seed every repo that I actively use for my code that's also
            hosted on Radicle.

            Be sure to also check out my GitHub at https://github.com/tophcodes.
          '';
          pinned.repositories = [
            "rad:z4VmSKKMbAqbwqsMXWvyvrxTSAZFS"
          ];
        };
      };
    };

    traefik.routes.radicle-seed = {
      rule = "Host(`${nodeAddress}`)";
      url = "http://localhost:${builtins.toString radConfig.httpd.listenPort}";
    };
  };
}

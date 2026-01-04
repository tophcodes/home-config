{pkgs, ...}: let
  name = "radicle.toph.so";

  explorer = pkgs.radicle-explorer.withConfig {
    preferredSeeds = [
      {
        hostname = "seed.toph.so";
        port = 443;
        scheme = "https";
      }
    ];
  };
in {
  services = {
    static-web-server.configuration.advanced = {
      rewrites = [
        {
          source = "{**}";
          destination = "https://${name}/";
        }
      ];
      virtual-hosts = [
        {
          host = name;
          root = explorer;
        }
      ];
    };

    traefik.routes.radicle = {
      rule = "Host(`${name}`)";
      url = "http://localhost:89";
    };
  };
}

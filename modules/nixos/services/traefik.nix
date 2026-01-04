{
  config,
  lib,
  ...
}: let
  cfg = config.services.traefik;

  routeOptions = lib.types.submodule {
    options = {
      rule = lib.mkOption {
        type = lib.types.str;
        example = "Host(`example.com`)";
        description = "Traefik routing rule";
      };

      url = lib.mkOption {
        type = lib.types.str;
        example = "http://localhost:8096";
        description = "Backend service URL";
      };

      entryPoints = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = ["websecure"];
        description = "Entry points for this route";
      };

      certResolver = lib.mkOption {
        type = lib.types.str;
        default = "letsencrypt";
        description = "Certificate resolver to use";
      };

      middlewares = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Middlewares to apply to this route";
        example = ["auth" "compress"];
      };
    };
  };

  mkRouter = service: routeCfg:
    {
      inherit service;
      rule = routeCfg.rule;
      entryPoints = routeCfg.entryPoints;
      tls.certResolver = routeCfg.certResolver;
    }
    // lib.optionalAttrs (routeCfg.middlewares != []) {
      middlewares = routeCfg.middlewares;
    };

  mkService = name: routeCfg: {
    loadBalancer.servers = [
      {url = routeCfg.url;}
    ];
  };

  dynamicConfigOptions = {
    http = {
      routers = lib.mapAttrs mkRouter cfg.routes;
      services = lib.mapAttrs mkService cfg.routes;
    };
  };
in {
  options.services.traefik = {
    postmasterEmail = lib.mkOption {
      type = lib.types.str;
      example = "email@example.com";
      description = "The email address of the postmaster";
    };

    routes = lib.mkOption {
      type = lib.types.attrsOf routeOptions;
      default = {};
      description = "Simple route definitions for Traefik";
      example = lib.literalExpression ''
        {
          solid-pod = {
            rule = "Host(`solid.my.dev`)";
            url = "http://localhost:8096";
          };
          radicle = {
            rule = "Host(`radicle.my.dev`)";
            url = "http://localhost:8097";
          };
        }
      '';
    };
  };

  config = lib.mkIf (cfg.enable && cfg.routes != {}) {
    networking.firewall.allowedTCPPorts = [80 443];

    services.traefik = {
      inherit dynamicConfigOptions;
      staticConfigOptions = {
        entryPoints = {
          web = {
            address = ":80";
            asDefault = true;
            http.redirections.entrypoint = {
              to = "websecure";
              scheme = "https";
            };
          };

          websecure = {
            address = ":443";
            asDefault = true;
            http.tls.certResolver = "letsencrypt";
          };
        };

        log = {
          level = "DEBUG";
          filePath = "${config.services.traefik.dataDir}/traefik.log";
          format = "json";
        };

        certificatesResolvers.letsencrypt.acme = {
          email = config.services.traefik.postmasterEmail;
          storage = "${config.services.traefik.dataDir}/acme.json";

          # dnsChallenge.provider = "cloudflare";
          # TODO: Declaratively determine whether to use staging or production
          #       based on whether we are in testing.
          # caServer = "";
          httpChallenge.entryPoint = "web";
        };
      };
    };
  };
}

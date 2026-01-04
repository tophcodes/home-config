{
  inputs,
  pkgs,
  ...
}: {
  services = {
    matrix-synapse = {
      enable = true;

      settings = {
        server_name = "aleph.garden";
        public_baseurl = "https://matrix.aleph.garden";

        listeners = [
          {
            port = 8008;
            type = "http";
            x_forwarded = true;
            tls = false;
            resources = [{names = ["client" "federation"];}];
          }
        ];
      };
    };

    # mautrix-whatsapp.enable = true;
    # mautrix-telegram.registerToSynapse = {};
    # mautrix-signal.registerToSynapse = {};
    # mautrix-discord.enable = true;

    traefik.routes.matrix = {
      rule = "Host(`matrix.aleph.garden`)";
      url = "http://localhost:8008";
    };
  };
}

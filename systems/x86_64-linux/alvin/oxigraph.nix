{pkgs, ...}: {
  # Create dedicated user and group
  users.users.oxigraph = {
    isSystemUser = true;
    group = "oxigraph";
    description = "Oxigraph SPARQL database service user";
  };

  users.groups.oxigraph = {};

  # Configure systemd service
  systemd.services.oxigraph = {
    description = "Oxigraph SPARQL database server";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      ExecStart = "${pkgs._elements.oxigraph}/bin/oxigraph serve --location /var/lib/oxigraph --bind 127.0.0.1:7878";
      Restart = "on-failure";
      User = "oxigraph";
      Group = "oxigraph";
      StateDirectory = "oxigraph";

      # Security hardening
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = "/var/lib/oxigraph";
    };
  };

  # Configure Traefik route for public access
  services.traefik.routes.sparql = {
    rule = "Host(`sparql.toph.so`)";
    url = "http://localhost:7878";
  };
}

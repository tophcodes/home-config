{
  inputs,
  config,
  pkgs,
  ...
}: {
  services = {
    telegraf = {
      enable = true;
      environmentFiles = [
        # This defines the VICTORIAMETRICS_PASSWORD environment variable
        config.age.secrets.victoriametricsEnvFile.path
      ];
      extraConfig = {
        inputs = {
          http_response = [
            {
              urls = ["https://toph.so" "https://aleph.garden" "https://aph.gdn" "https://radicle.toph.so"];
            }
          ];
          internet_speed = [
            {
              interval = "60m";
            }
          ];
        };
        outputs.influxdb = [
          {
            urls = ["https://vm.toph.so"];
            database = "toph";
            username = "victoria-with-the-secrets";
            password = "\${VICTORIAMETRICS_PASSWORD}";
            skip_database_creation = false;
            exclude_retention_policy_tag = true;
            content_encoding = "gzip";
          }
        ];
      };
    };

    # traefik.routes.solid-pod = {
    #   rule = "Host(`pod.toph.so`)";
    #   url = "http://localhost:3000";
    # };
  };

  # systemd.tmpfiles.rules = [
  #   "d /var/lib/solid - - - - -"
  # ];
}

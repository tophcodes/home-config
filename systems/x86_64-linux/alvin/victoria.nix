{config, ...}: {
  services = {
    victoriametrics = {
      enable = true;
      retentionPeriod = "5y";

      basicAuthUsername = "victoria-with-the-secrets";
      basicAuthPasswordFile = config.age.secrets.victoriametricsPasswordFile.path;
    };

    traefik.routes.victoriametrics = {
      rule = "Host(`vm.toph.so`)";
      url = "http://localhost:8428";
    };
  };
}

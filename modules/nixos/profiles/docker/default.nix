{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.bosun.profiles.docker.enable {
    virtualisation.docker = {
      enable = true;

      # https://github.com/hausgold/knowledge/blob/master/troubleshooting/local-env-quirks.md#haproxy--docker-ulimit-glitch
      daemon.settings = {
        default-ulimits = {
          nofile = {
            Hard = 100000;
            Soft = 100000;
            Name = "nofile";
          };
        };
      };
    };
  };
}

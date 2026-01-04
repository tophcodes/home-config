{
  config,
  lib,
  ...
}: {
  services.traefik = {
    enable = true;
    postmasterEmail = "hosting@muehl.dev";

    # routes = {
    #   staticsite = {
    #     rule = "Host(`toph.so`)";
    #     url = "http://localhost:8080";
    #   };

    #   solid-pod = {
    #     rule = "Host(`solid.toph.so`)";
    #     url = "http://localhost:8096";
    #   };

    #   radicle = {
    #     rule = "Host(`radicle.toph.so`)";
    #     url = "http://localhost:8097";
    #   };

    #   forgejo = {
    #     rule = "Host(`git.toph.so`)";
    #     url = "http://localhost:3000";
    #   };
    # };
  };
}

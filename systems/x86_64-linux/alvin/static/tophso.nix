{pkgs, ...}: let
  name = "toph.so";

  tophso = pkgs.writeTextFile {
    inherit name;
    destination = "/index.html";
    text = ''
      <!DOCTYPE html>
      <html>
        <head>
          <title>toph.so</title>
          <meta charset="utf-8"/>
        </head>
        <body>
          <a rel="me" href="https://mas.to/@padarom">Mastodon</a>
        </body>
      </html>
    '';
  };
in {
  services = {
    static-web-server.configuration.advanced.virtual-hosts = [
      {
        host = name;
        root = tophso;
      }
    ];

    traefik.routes.toph = {
      rule = "Host(`${name}`)";
      url = "http://localhost:89";
    };
  };
}

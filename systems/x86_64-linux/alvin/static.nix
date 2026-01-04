{...}: let
  root = "/var/lib/sws";
in {
  imports = [
    ./static/tophso.nix
    ./static/radicle-explorer.nix
  ];

  services = {
    static-web-server = {
      enable = true;
      listen = "[::]:89";
      inherit root;
      configuration = {};
    };
  };

  systemd.tmpfiles.rules = [
    "d ${root} - - - - -"
  ];
}

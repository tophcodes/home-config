{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.lnxlink;
in {
  options.services = {
    lnxlink = {
      enable = mkEnableOption "Enable LNXlink";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.lnxlink = {
      enable = true;
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        # Note: Logging will also be done to the working directory, so logs will
        # be lost upon a restart.
        WorkingDirectory = "/tmp";
        ExecStart = "${pkgs.harbor.lnxlink}/bin/lnxlink -i -c ${./lnxlink.yaml}";
      };
    };
  };
}

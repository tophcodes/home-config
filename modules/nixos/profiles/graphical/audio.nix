{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkForce mkDefault;
in {
  imports = [
    inputs.musnix.nixosModules.default
  ];

  config = mkIf config.bosun.profiles.graphical.enable {
    musnix = {
      enable = mkDefault true;
      rtcqs.enable = true;
    };

    users.users.toph.extraGroups = ["audio"];

    services.pipewire = {
      enable = mkForce true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}

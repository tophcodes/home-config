{
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkForce mkDefault;
in {
  imports = [
    inputs.musnix.nixosModules.default
  ];

  config = {
    musnix = {
      enable = mkDefault true;
      rtcqs.enable = true;
    };

    users.users.toph.extraGroups = ["audio"];

    pipewire = {
      enable = mkForce true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };
}

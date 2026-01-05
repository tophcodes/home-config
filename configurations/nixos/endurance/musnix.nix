{inputs, ...}: {
  imports = [
    inputs.musnix.nixosModules.default
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;
  };

  users.users.toph.extraGroups = ["audio"];
}

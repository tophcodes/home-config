{inputs, ...}: let
  inherit (inputs) self;

  mkHost = hostname: config:
    {
      path = ../../configurations/nixos/${hostname};
      deployable = true;
      specialArgs = {inherit inputs hostname;};
    }
    // config;
in {
  imports = [inputs.easy-hosts.flakeModule];

  config.easy-hosts = {
    shared.modules = [
      ../generic/default.nix
    ];

    perClass = class: {
      modules = [
        "${self}/modules/${class}/default.nix"
      ];
    };

    hosts = {
      endurance = mkHost "endurance" {};

      aepplet = mkHost "aepplet" {};

      vasa = mkHost "vasa" {
        class = "darwin";
      };
    };
  };
}

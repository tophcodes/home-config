{
  inputs,
  inputs',
  ...
}: let
  inherit (inputs) self;

  mkHost = host: config:
    {
      path = ../../configurations/nixos/${host};
      deployable = true;

      specialArgs = {
        inherit inputs inputs';
        hostname = host;
      };
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

{
  self,
  inputs,
  ...
}: {
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
      endurance = {
        path = ../../configurations/nixos/endurance;
        class = "nixos";
      };

      vasa = {
        path = ../../configurations/darwin/vasa;
        class = "darwin";
      };

      aepplet = {
        path = ../../configurations/nixos/aepplet;
        class = "nixos";
      };
    };
  };
}

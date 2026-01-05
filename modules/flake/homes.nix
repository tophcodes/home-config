{inputs, ...}: let
  inherit (inputs) self;

  mkHome = user: host: {
    imports = [
      (self + "/configurations/home/${user}@${host}")
      (self + "/modules/home")
    ];
  };
in {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations = {
    "toph@endurance" = mkHome "toph" "endurance";
    "toph@vasa" = mkHome "toph" "vasa";
    "toph@aepplet" = mkHome "toph" "aepplet";
  };
}

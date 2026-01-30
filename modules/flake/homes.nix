{inputs, ...}: let
  inherit (inputs) self;

  mkHome = user: host: system: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    extraSpecialArgs = {
      inherit inputs;
      hostname = host;
    };

    modules = [
      (self + "/modules/home")
      (self + "/home/by-host/${host}")
    ];
  };
in {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations = {
    "toph@endurance" = mkHome "toph" "endurance" "x86_64-linux";
    "toph@vasa" = mkHome "toph" "vasa" "x86_64-darwin";
  };
}

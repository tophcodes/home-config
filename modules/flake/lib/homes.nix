{inputs, ...}: let
  inherit (inputs) self;
in {
  mkHome = user: host: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    users.users.${user}.isNormalUser = true;

    home-manager.users.${user} = inputs.self.homeConfigurations."${user}@${host}";
  };
}

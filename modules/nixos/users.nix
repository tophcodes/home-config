{
  inputs,
  pkgs,
  hostname,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = {
    bosun.secrets.tophPassword = "toph-password.age";

    programs.fish.enable = true;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.toph = inputs.self.homeConfigurations."toph@${hostname}";

      extraSpecialArgs = {
        inherit inputs hostname;
      };
    };

    users = {
      users.toph = {
        isNormalUser = true;
        initialPassword = "wheel";
        # hashedPasswordFile = config.age.secrets.tophPassword.path;
        shell = pkgs.fish;

        extraGroups = [
          "wheel"
          "docker"
          "dialout"
          "uinput"
          "pico"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEqcR3f71g7yuxQtUewrqdoEh8jDHtkB1973GF0EQ6q christopher@all"
        ];
      };

      groups.toph = {
        members = ["toph"];
        gid = 1000;
      };
    };
  };
}

{inputs, ...}: {
  systems = [
    "x86_64-linux"
    "x86_64-darwin"
  ];

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };

      overlays = [];
    };
  };
}

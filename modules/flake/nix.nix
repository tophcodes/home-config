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
        permittedInsecurePackages = [
          "nixos-config"
          "electron-36.9.5"
          "dotnet-sdk-6.0.428"
          "olm-3.2.16"
        ];
      };

      overlays = [];
    };
  };
}

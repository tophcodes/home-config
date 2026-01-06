{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    # TODO: Is this even needed with lix?
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';

    # automatic cleanup
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };

    settings = {
      # builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";

      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];
      substituters = ["https://cache.nixos.org/"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "cider-2"
        ];

      permittedInsecurePackages = [
        # "nixos-config"
        # "electron-36.9.5"
        # "dotnet-sdk-6.0.428"
        "olm-3.2.16"
      ];
    };

    overlays = import ../../overlays {inherit inputs lib;};
  };
}

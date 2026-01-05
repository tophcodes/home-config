{
  inputs,
  lib,
  ...
}: {
  systems = [
    "x86_64-linux"
    "x86_64-darwin"
  ];

  perSystem = {
    system,
    self',
    ...
  }: {
    # these settings only apply to flake-local packages being built, not to the
    # nixpkgs instance within host and home configurations
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      overlays = [
        (final: prev: {
          writeNushellApplication = import ./lib/writeNushellApplication.nix {
            inherit lib;
            pkgs = prev;
          };
        })
      ];
    };
  };
}

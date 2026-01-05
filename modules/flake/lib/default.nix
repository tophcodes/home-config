{
  lib,
  inputs,
  ...
}: {
  flake.lib = lib.fixedPoints.makeExtensible (final: {
    # secrets = import ./secrets.nix {inherit inputs lib;};
    # inherit (final.secrets) mkSecret;
  });
}

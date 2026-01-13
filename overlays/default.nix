{
  lib,
  inputs,
  ...
}: let
  inherit (lib.attrsets) mapAttrs;

  # wrapper that provides channels arg to each overlay
  withChannels = overlayFn: final: prev: let
    # Import channels with the same config as the main nixpkgs
    importChannel = input:
      import input {
        system = final.stdenv.hostPlatform.system;
        config = final.config;
      };
  in
    overlayFn {
      inherit inputs lib;
      channels =
        {
          nixpkgs = final;
        }
        // mapAttrs (
          _: input:
            importChannel input
        )
        inputs;
    }
    final
    prev;
in [
  (withChannels (import ./lix.nix))
  (withChannels (import ./packages.nix))
  (withChannels (import ./unstable.nix))
  (withChannels (import ./spacedrive.nix))
]

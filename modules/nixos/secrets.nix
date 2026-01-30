{
  config,
  inputs',
  inputs,
  hostname,
  pkgs,
  lib,
  self,
  ...
}: {
  imports = [
     inputs.agenix.nixosModules.default 
     inputs.agenix-rekey.nixosModules.default
     ../generic/secrets.nix
  ];
}

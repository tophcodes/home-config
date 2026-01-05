{lib, ...}: {
  perSystem = {
    config,
    pkgs,
    inputs',
    ...
  }: {
    packages = lib.filesystem.packagesFromDirectoryRecursive {
      callPackage = pkgs.callPackage;
      directory = ../../packages;
    };
  };
}

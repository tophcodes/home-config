{
  pkgs,
  hostname,
  ...
}: {
  # the `modules/generic` folder is generic only across nixos and darwin, not
  # across home manager. home modules are in `modules/home`
  imports = [
    ./nix.nix
    ./profiles.nix
    ./secrets.nix
  ];

  # TODO: Move all of these into their own modules?

  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    pre-commit
    git
    gitleaks
    helix
    fish
    just
    nh
    age
  ];
}

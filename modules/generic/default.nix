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
    ./ssh.nix
  ];

  # TODO: Move all of these into their own modules?

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  networking.hostName = hostname;

  environment.systemPackages = with pkgs; [
    pre-commit
    git
    gitleaks
    just
    nh
    age
  ];
}

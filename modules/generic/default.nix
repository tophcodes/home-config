{ pkgs, ... }: {
  # the `modules/generic` folder is generic only across nixos and darwin, not
  # across home manager. home modules are in `modules/home`
  imports = [
    ./nix.nix
    ./profiles.nix
    ./secrets.nix
  ];

  environment.systemPackages = with pkgs; [
    pre-commit
    git
    gitleaks
    just
    nh
    age
  ];
}

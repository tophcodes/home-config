{
  imports = [
    ./services
    ./profiles
    ./system.nix
    ./users.nix
    ./nix-ld.nix
    ./ssh.nix
    ./secrets.nix
  ];

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
}

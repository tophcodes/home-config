{pkgs, ...}: {
  bosun.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBUKDCjB0VpQubi8BfnYKbh4MIE1tcvKQesdoPE4NXAf";

  home.packages = with pkgs; [
    helix
  ];
}

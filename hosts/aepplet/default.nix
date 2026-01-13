{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  bosun = {
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjqieS4GkYAa1WRYZpxjgYsj7VGZ9U+rTFCkX8M0umD";

    profiles = {
      docker.enable = true;
      work.enable = true;
    };
  };

  system.stateVersion = "24.11";

  # Set the default drive, which in the case of Mercury is
  # a VirtualBox image.
  disko.devices.disk.main.device = "/dev/sda";

  boot.loader.grub.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.docker-compose-1.legacyPackages."x86_64-linux".docker-compose
    gnumake
  ];

  programs = {
    vim.enable = true;
    git.enable = true;
  };

  # Disable the firewall so that all traffic is allowed
  networking.firewall.enable = false;

  # Reflect mDNS to host network
  services.avahi.reflector = true;

  # Forward external traffic internally
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}

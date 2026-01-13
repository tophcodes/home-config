{pkgs, ...}: {
  bosun.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl33DPxxzxrNNjM8rL4ktAj4ExzCyGiU8rKog0csxNA";

  home.packages = with pkgs; [
    harbor.to-s3
    harbor.connect-to-mercury
  ];
}

{
  pkgs,
  config,
  ...
} @ all: {
  bosun.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl33DPxxzxrNNjM8rL4ktAj4ExzCyGiU8rKog0csxNA";

  imports =
    [
    ];

  home.username = "christopher";
  home.homeDirectory = "/Users/christopher";

  elements.kitty.enable = true;
}

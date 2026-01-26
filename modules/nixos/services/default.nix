{...}: {
  imports = [
    ./ollama.nix
    ./traefik.nix
    ./metrics.nix
  ];
}

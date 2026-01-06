{
  pkgs,
  lib,
  ...
}:
pkgs.python3Packages.buildPythonApplication {
  pname = "lnxlink";
  version = "2025.7.0";
  pyproject = true;

  # Linking my fork here which allows for newer versions of setuptools and wheel.
  # Also includes some fixes that make the program actually work with NixOS.
  src = pkgs.fetchFromGitHub {
    owner = "padarom";
    repo = "lnxlink";
    rev = "7202e48";
    hash = "sha256-E2J1d9D5SJWGEutAPAo1BM98cMzH7QrqIz3yrlXpzGE=";
  };

  build-system = with pkgs.python3Packages; [setuptools wheel];
  dependencies = with pkgs.python3Packages; [
    distro
    pyyaml
    paho-mqtt
    requests
    psutil
    inotify
    jeepney
  ];

  meta = {
    homepage = "https://github.com/bkbilly/lnxlink";
    description = "Effortlessly manage your Linux machine using MQTT.";
    license = lib.licenses.mit;
    mainProgram = "lnxlink";
  };
}

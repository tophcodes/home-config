{
  lib,
  pkgs,
  ...
}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "dedoc";
  version = "0.2.9";

  src = pkgs.fetchFromGitHub {
    owner = "toiletbril";
    repo = "dedoc";
    rev = version;
    hash = "sha256-B/lZ1G/C/VnSO8Rk67Lhf+hgh97nVooLAu6TxxT0VGs=";
  };

  postPatch = ''
    substituteInPlace Cargo.toml --replace "1.92" "1.91"
  '';

  cargoHash = "sha256-gW7DXJVAxZTTlUD/7+UL0Hk1xeL+HDByfgnoVQRZaOI=";

  meta = {
    description = "Terminal based viewer for DevDocs";
    homepage = "https://github.com/toiletbril/dedoc";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [];
    mainProgram = "dedoc";
  };
}

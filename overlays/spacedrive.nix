{
  channels,
  lib,
  ...
}: final: prev: {
  spacedrive-v2 = channels.unstable.spacedrive.overrideAttrs (old: {
    version = "2.0.0-alpha.1";
    src = prev.fetchurl {
      url = "https://github.com/spacedriveapp/spacedrive/releases/download/v2.0.0-alpha.1/Spacedrive-linux-x86_64.deb";
      hash = "sha256-26qxNO17DTYQSYtH6aRy0PoNpb4BGeoZWOQWZtfV3IY=";
    };

    buildInputs =
      (old.buildInputs or [])
      ++ (with channels.unstable; [
        libheif
        ffmpeg_7-full.lib
      ]);
  });
}

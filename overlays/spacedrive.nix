{
  channels,
  lib,
  ...
}: final: prev: {
  spacedrive_v2 = channels.unstable.spacedrive.overrideAttrs (old: {
    src = prev.fetchurl {
      url = "https://github.com/spacedriveapp/spacedrive/releases/download/v2.0.0-alpha.1/Spacedrive-linux-x86_64.deb";
      hash = lib.fakeHash;
    };
  });
}

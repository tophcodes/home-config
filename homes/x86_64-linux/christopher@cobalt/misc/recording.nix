{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    droidcam
    davinci-resolve
    ffmpeg
  ];
}

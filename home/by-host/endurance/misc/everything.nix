{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    gnupg
    unzip
    dua # Interactively view disk space usage
    numbat # Scientific calculations
    yubikey-manager
    croc # File transfer
    solaar # Logitech mouse driver
    btop # Better resource monitor
    bottom # System resource monitor
    grim # Screenshots
    slurp # Region selection

    # Productivity
    obsidian # Note taking
    todoist-electron # To-Do List app
    thunderbird # Email client
    onlyoffice-desktopeditors # libreoffice alternative
    speedcrunch # GUI calculator app
    calibre # eBook Manager
    spacedrive-v2
    # loupe # Photo viewer

    (dokieli.overrideAttrs
      (final: prev: {
        installPhase = ''
          runHook preInstall
          mkdir -p $out/bin
          cp -r * $out
          rm $out/LICENSE
          runHook postInstall
        '';
      }))
    cider-2 # Apple music player
    fractal # Matrix client
    gomuks # Matrix client TUI
    filezilla # FTP Client
    mochi # SRS flashcards
  ];
}

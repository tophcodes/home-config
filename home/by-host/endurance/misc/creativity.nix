{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #inputs.affinity-nix.packages.${pkgs.stdenv.hostPlatform.system}.v3 # adobe suite replacement
    gmic # greyc's magic

    krita
    krita-plugin-gmic

    gimp
    gimpPlugins.gmic
    # gimpPlugins.bimp # batch image manipulation, broken atm
    # rawtherapee

    # CAD
    freecad
    openscad
    antimony

    vcv-rack # eurorack synth simulator
    supercollider # audio programming language
  ];

  # - the nixpkgs version crashes once logged in
  # - flatpaks somehow can't be installed via HM
  # - need to manually a desktop entry for the flatpak
  xdg.desktopEntries.bambustudio = {
    name = "Bambu Studio";
    exec = "flatpak run com.bambulab.BambuStudio";
  };
}

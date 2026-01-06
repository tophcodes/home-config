{pkgs, ...}: {
  home.packages = with pkgs; [
    font-manager
    google-fonts
    kdePackages.kcharselect
  ];

  fonts.fontconfig.enable = true;

  stylix.fonts = {
    monospace = {
      name = "Monaspace Neon NF";
      package = pkgs.nerd-fonts.monaspace;
    };

    sizes = {
      applications = 12;
      terminal = 13;
      desktop = 10;
      popups = 10;
    };
  };

  programs.kitty.settings = {
    font_family = "family='MonaspiceNe Nerd Font' style='Light'";
    bold_font = "family='MonaspiceNe Nerd Font' style='Bold'";
  };

  # home.file.".local/share/fonts" = {
  #   # This includes FontAwesome and other proprietary fonts which are licensed,
  #   # so I have to download them from a private repository
  #   source = builtins.fetchGit {
  #     url = "git@github.com:padarom/fonts.git";
  #     rev = "2defdedf6642865648c8e57b3851a77ac0ae2d7b";
  #   };
  #   recursive = true;
  # };
}

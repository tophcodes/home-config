{...}: {
  programs.niri.settings.spawn-at-startup = [
    # open fastfetch by default
    {argv = ["kitty" "--title" "'fastfetch'" "sh" "-c" "'fastfetch; read'"];}
  ];
}

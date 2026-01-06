{...}: {
  programs.niri.settings.spawn-at-startup = [
    # this is a funny fix for xdg environment not properly being set and thus
    # xdg-open not working properly
    {argv = ["sleep" "5;" "systemctl" "--user" "restart" "xdg-desktop-portal"];}

    # open fastfetch by default
    {argv = ["kitty" "--title" "'fastfetch'" "sh" "-c" "'fastfetch; read'"];}
  ];
}

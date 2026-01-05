{channels, ...}: final: prev: {
  # Pull the following packages from unstable instead
  inherit
    (channels.unstable)
    kitty
    nu
    cider-2
    _1password-gui
    orca-slicer
    claude-code
    lutris
    ollama
    dokieli
    nix-init
    atuin-desktop
    # currently doesn't build on unstable
    # open-webui
    ;

  inherit (channels.master) install-nothing;
}

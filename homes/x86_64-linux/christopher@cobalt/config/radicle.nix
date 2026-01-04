{pkgs, ...}: {
  home.packages = with pkgs; [
    radicle-tui
    radicle-desktop
  ];

  programs.radicle = {
    enable = true;
    settings = {
      connect = ["z6MkjLnQeLFcgE2AQ3BRMYGr3npNnctcGpABZLEHpmvHdrjX@seed.toph.so:8776"];
      node.alias = "toph";
    };
  };
}

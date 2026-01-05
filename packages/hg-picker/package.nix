{pkgs, ...}:
pkgs.writeShellApplication {
  name = "hg-picker";

  text = ''
    BASE_URI="https://github.com/hausgold/"
    REPO=$(cat "$HOME/.gh/hausgold-repos" | fuzzel -d)

    if [[ -n $REPO ]]; then
        xdg-open "$BASE_URI$REPO"
    fi
  '';
}

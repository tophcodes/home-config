{
  pkgs,
  config,
  lib,
  inputs,
  ...
} @ all: {
  imports =
    [
      # inputs.ovos.homeManagerModules.default

      ./ssh.nix
      ./email.nix
      ./gpg
      ./niri
      ./stylix.nix
      ./default-applications.nix
      ./misc/launcher.nix
      ./misc/browser.nix
      ./misc/gaming.nix
      ./misc/onedrive.nix
      ./misc/creativity.nix
      ./misc/recording.nix
      ./misc/everything.nix # TODO: Determine if we really always want all these programs or they should be composable
      ./global/current-packages.nix
    ]
    ++ (import ./config.nix all);

  elements.secrets = {
    rekeyPath = "christopher_cobalt";
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl33DPxxzxrNNjM8rL4ktAj4ExzCyGiU8rKog0csxNA";

    needs = {
      repoUpdatePAT = "repo-update-pat.age";
      emailPassword = "email-password.age";
      npmrc = {
        rekeyFile = "npmrc.age";
        path = "${config.home.homeDirectory}/.npmrc";
      };
    };
  };

  elements.kitty.enable = true;

  services = {
    activitywatch = {
      enable = true;
      watchers = {
        aw-watcher-afk.settings = {
          timeout = 300;
          poll_time = 2;
        };

        aw-watcher-window.settings = {
          poll_time = 1;
          exclude_title = false;
        };
      };
    };

    # ovos = {
    #   language = "de-de";
    #
    #   audio = {
    #     enable = true;
    #     voice = "de_DE-thorsten-medium";
    #     logLevel = "DEBUG";
    #   };
    #
    #   listener.enable = true; # STT input (requires microphone)
    #   skills.enable = true; # Intent processing
    # };
  };

  programs.fastfetch = let
    ansiLogo = pkgs.fetchFromGitHub {
      owner = "4DBug";
      repo = "nix-ansi";
      rev = "3be6d1d";
      sha256 = "sha256-QmoyLTDZu7gmkmU25FX6eNZfqqdYoqPaWGJnsSC+kg4=";
    };
  in {
    enable = true;
    settings = {
      logo = {
        type = "file";
        source = "${ansiLogo}/nix.txt";
      };

      display.separator = " → ";

      modules = [
        {
          type = "title";
          key = "";
        }

        "break"
        {
          type = "os";
          key = "os";
          format = "{2}";
        }
        {
          type = "kernel";
          key = "";
        }
        {
          type = "packages";
          key = "";
        }

        "break"
        {
          type = "wm";
          key = "";
        }
        {
          type = "terminal";
          key = "";
        }
        {
          type = "shell";
          key = "";
        }

        "break"
        {
          type = "cpu";
          key = "";
        }
        {
          type = "gpu";
          key = "";
        }
        {
          type = "memory";
          key = "";
        }

        "break"
        {
          type = "disk";
          key = "";
          # format = "{mountpoint}";
        }
        {
          type = "swap";
          key = "";
        }

        "break"
        {
          type = "monitor";
          key = "";
        }
        {
          type = "keyboard";
          key = "";
        }
      ];
    };
  };

  home = {
    extraOutputsToInstall = ["doc" "devdoc"];

    packages = with pkgs._elements; [
      quick-zeal
      spawn-term
    ];
  };

  # home.file.".config/Yubico/u2f_keys".text = "christopher:C7akk/T8XYov6fOk3rGo0ZW66QPMtdLnGznPuK+tTh/qmPecvECzGVMKJuh5M7nYsMoT6r/idAP88FGinf/rpw==,ydS/PgUALZriaaHYS81u3x8rRFulq727GDJRlvbJhP2yeKK7Ih+xqRceyabLR3MxRN8PT/MtC1I/Xjaxl0S2Rg==,es256,+presence";
}

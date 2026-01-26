{
  pkgs,
  config,
  ...
}: let
  serverConfig = {
    imap.host = "europium.gutentag.games";
    smtp.host = "europium.gutentag.games";

    userName = "christopher";
    passwordCommand = "cat ${config.age.secrets.emailPassword.path}";
  };
in {
  bosun.secrets.emailPassword = "email-password.age";

  programs = {
    # TODO: Move this into its own file
    irssi = {
      enable = true;
      networks."w3c" = {
        server.address = "irc.w3c.org";
        nick = "tophcodes";
        channels."crdt4rdf".autoJoin = true;
      };
    };

    # Syncs my mailbox for other programs to digest more easily
    mbsync.enable = true;

    # CLI-based email client
    aerc = {
      enable = true;

      # This is necessary because `accounts.email` symlinks the configuration
      # for aerc to use. Since there are no secrets in it, this is safe to do,
      # so we need to tell aerc to ignore the "too lax" permissions on that file
      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
        };

        viewer = {
          # pager = ''

          # '';
        };

        filters = ''
          text/plain=less
          application/pdf=tdf $AERC_FORMAT
          message/delivery-status=less
          message/rfc822=less
          text/html=reader
          text/*=bat -fP
        '';
      };
    };

    # Query emails via CLI
    notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };
  };

  home.packages = with pkgs; [
    reader
    tdf
    slack
    telegram-desktop
    vesktop # Discord client
    # jitsi-meet
  ];

  accounts.email = {
    accounts = {
      europium =
        {
          primary = true;
          realName = "Christopher Mühl";
          address = "christopher@muehl.dev";

          aerc.enable = true;
          notmuch.enable = true;
          mbsync = {
            enable = true;
            create = "maildir";
          };
        }
        // serverConfig;
    };
  };
}

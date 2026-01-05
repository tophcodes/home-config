{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.elements;
in
  with lib;
  with builtins; {
    options = {
      elements = {
        users = mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
    };

    config = {
      bosun.secrets.tophPassword = "toph-password.age";

      programs.fish.enable = true;

      users = {
        users.toph = {
          isNormalUser = true;
          # hashedPasswordFile = config.age.secrets.tophPassword.path;
          shell = pkgs.fish;

          extraGroups = [
            "wheel"
            "docker"
            "dialout"
            "uinput"
            "pico"
          ];

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBEqcR3f71g7yuxQtUewrqdoEh8jDHtkB1973GF0EQ6q christopher@all"
          ];
        };

        groups.toph = {
          members = ["toph"];
          gid = 1000;
        };
      };
    };
  }

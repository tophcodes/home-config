{
  config,
  inputs',
  inputs,
  hostname,
  pkgs,
  lib,
  self,
  ...
}:
with lib; let
  cfg = config.bosun;
in {
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];

  options.bosun = {
    rekeyPath = mkOption {
      type = types.str;
      default = hostname;
    };

    key = mkOption {
      type = types.str;
    };

    secrets = mkOption {
      type = types.attrsOf (types.either types.str types.attrs);
      default = {};
    };
  };

  # TODO: Make this work for both home manager and nixos
  config = {
    environment.systemPackages = [
      pkgs.age-plugin-yubikey
      inputs'.agenix-rekey.packages.default
    ];

    age = {
      # general host setup
      rekey = {
        hostPubkey = cfg.key;

        # See https://github.com/oddlama/agenix-rekey?tab=readme-ov-file#local
        # for potential effects of this decision.
        storageMode = "local";
        localStorageDir = self + "/secrets/rekeyed/${cfg.rekeyPath}";

        # Used to decrypt stored secrets for rekeying.
        masterIdentities = [
          (self + "/secrets/keys/master-identity.pub")
        ];

        # Keys that will always be encrypted for. These act as backup keys in
        # case the master identities are somehow lost.
        extraEncryptionPubkeys = [
          "age1zd8wxnmgf04qcan9cvs0736valy8407f497fw9j0auwf072yadzqqdqsj9"
        ];
      };

      # map all simplified secrets from `config.bosun.secrets` to their
      # respective `config.age.secrets` mapping
      secrets =
        lib.attrsets.mapAttrs (
          name: secret: (
            if builtins.isString secret
            then {rekeyFile = self + "/secrets/${secret}";}
            else secret // {rekeyFile = self + "/secrets/${secret.rekeyFile}";}
          )
        )
        cfg.secrets;
    };
  };
}

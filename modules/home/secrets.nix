{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.bosun;
in {
  imports = [
    inputs.agenix.homeManagerModules.default
    # inputs.agenix-rekey.homeManagerModules.default
  ];

  options.bosun = {
    rekeyPath = mkOption {
      type = types.str;
    };

    key = mkOption {
      type = types.str;
    };

    secrets = mkOption {
      type = types.attrsOf (types.either types.str types.attrs);
      default = {};
    };
  };

  config.age =
    (lib.bosun.mkAgenixConfig inputs.self cfg)
    // {
      identityPaths = ["${config.home.homeDirectory}/.ssh/key"];
      secretsDir = "${config.home.homeDirectory}/.local/share/agenix/agenix";
      secretsMountPoint = "${config.home.homeDirectory}/.local/share/agenix/agenix.d";
    };
}

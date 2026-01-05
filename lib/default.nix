{lib, ...} @ all: rec {
  rootPath = ./..;
  secret = name: ./../secrets/${name};

  writeNushellApplication = import ./writeNushellApplication.nix {inherit lib;};

  # Determines the file location of the passed in attr set (e.g. `{ sep = "#"; })
  # and prepends the string with it. This allows to add references to the source
  # file that wrote any setting to generated application configurations for debugging.
  selfReferencedString = {sep} @ attrs: str: let
    ref = builtins.unsafeGetAttrPos "sep" attrs;
  in
    "${sep} ${ref.file}:${builtins.toString ref.line}\n" + str;
}

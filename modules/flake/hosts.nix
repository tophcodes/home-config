{
  self,
  inputs,
  ...
}: {
  imports = [inputs.easy-hosts.flakeModule];

  config.easy-hosts = {
    hosts = {
      endurance = {};

      vasa = {
        arch = "aarch64";
        class = "darwin";
      };

      aepplet = {};
    };
  };
}

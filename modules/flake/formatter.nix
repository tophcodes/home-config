{...}: {
  perSystem = {pkgs, ...}: {
    formatter = pkgs.treefmt.withConfig {
      runtimeInputs = with pkgs; [
        deadnix # scans for dead code
        statix # static code analysis for nix
        alejandra # nix formatter
      ];

      settings = {
        on-unmatched = "info";
        tree-root-file = "flake.nix";

        excludes = ["secrets/*"];

        formatter = {
          deadnix = {
            command = "deadnix";
            options = ["--edit"];
            includes = ["*.nix"];
          };

          alejandra = {
            command = "alejandra";
            includes = ["*.nix"];
          };

          statix = {
            command = "statix-fix";
            includes = ["*.nix"];
          };
        };
      };
    };
  };
}

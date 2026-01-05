{
  description = "toph's system configuration";

  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    master.url = "github:NixOS/nixpkgs/master";

    # Flake framework
    flake-parts.url = "github:hercules-ci/flake-parts";
    easy-hosts.url = "github:tgirlcloud/easy-hosts";
    deploy-rs.url = "github:serokell/deploy-rs";

    # System management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix-rekey = {
      url = "github:oddlama/agenix-rekey";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop usage
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "unstable";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";
    musnix.url = "github:musnix/musnix";
    flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    git-global-log.url = "github:tophcodes/git-global-log";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    community-solid-server = {
      url = "github:tophcodes/CommunitySolidServer.nix/main";
    };

    # Custom
    ovos = {
      url = "git+file:///home/christopher/workspaces/mine/ovos-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waka-victoriametrics = {
      url = "git+file:///home/christopher/workspaces/mine/waka-victoriametrics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} (top @ {
      config,
      withSystem,
      moduleWithSystem,
      ...
    }: {
      imports = [
        inputs.agenix-rekey.flakeModules.default
        inputs.home-manager.flakeModules.home-manager
        ./modules/flake
      ];
    });
  # (inputs.snowfall.mkFlake {
  # inherit inputs;
  # src = ./.;

  # # Exposes all internal libs and packages as `lib._elements` or `pkgs._elements` respectively
  # snowfall.namespace = "_elements";

  # # Global system modules to be included for all systems
  # systems.modules = with inputs; {
  #   nixos = [
  #     disko.nixosModules.default
  #     ./modules/common
  #   ];
  #   darwin = [
  #     stylix.darwinModules.stylix
  #     ./modules/common
  #   ];
  # };

  # # Add modules only to specific hosts
  # systems.hosts = with inputs; {
  #         cobalt.modules = [
  #           niri.nixosModules.niri
  #           stylix.nixosModules.stylix
  #           musnix.nixosModules.default
  #           ovos.nixosModules.default
  #           waka-victoriametrics.nixosModules.default
  #         ];
  #       };

  #       homes.users = {
  #         # TODO: For some reason this needs to be toggled for agenix to work?
  #         # "christopher@cobalt".modules = with inputs; [
  #         #   niri.homeModules.niri
  #         # ];
  #       };

  #       # Configure nixpkgs when instantiating the package set
  #       # TODO: This is already specified elsewhere. Still needed here?
  #       channels-config = {
  #         allowUnfree = true;
  #         permittedInsecurePackages = [];
  #       };

  #       overlays = with inputs; [
  #         niri.overlays.niri
  #         nur.overlays.default
  #         ovos.overlays.default
  #         (final: prev: {
  #           waka-victoriametrics = waka-victoriametrics.packages.${final.system}.default;
  #         })
  #       ];

  #       outputs-builder = channels: {
  #         formatter = channels.nixpkgs.alejandra;
  #       };
  #     })
  #     // {
  #       agenix-rekey = inputs.agenix-rekey.configure {
  #         userFlake = inputs.self;
  #         nixosConfigurations = inputs.self.nixosConfigurations // inputs.self.darwinConfigurations;
  #         homeConfigurations = inputs.self.homeConfigurations;
  #       };
  #     };
  # }
}

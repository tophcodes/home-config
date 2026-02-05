{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    # Editors
    jetbrains-toolbox # Installer for JetBrains IDEs
    zed-editor
    code-cursor
    vscode

    atuin-desktop
    rfc # TUI-based RFC reader
    nix-init # Generate Nix packages from URLs
    install-nothing

    # Language Servers
    lua-language-server
    rust-analyzer
    nodePackages.typescript
    nodePackages.typescript-language-server
    nil # nix lsp

    # trurl # Parsing and manipulating URLs via CLI
    pandoc # Document converter
    ripgrep # Grep file search
    dig # DNS
    onefetch # Git information tool
    tokei # Like cloc
    gource # Git history viz
    zeal # Offline documentation browser
    harbor.dedoc # Terminal-based documentation viewer
    just # Just a command runner
    claude-monitor
    devenv
    gitui
    harbor.oryx # TUI for sniffing network traffic using eBPF

    # BMAD
    sox
    ffmpeg
    bc
    pipx
    piper-tts
    pulseaudioFull

    # Build tools
    cargo
    glibc
    gcc

    php82
    php82Packages.composer

    bun
    nodejs_20
    nodejs_20.pkgs.pnpm
  ];

  bosun.secrets.npmrc = {
    rekeyFile = "npmrc.age";
    path = "${config.home.homeDirectory}/.npmrc";
  };

  programs = {
    go.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;

      config.global.log_filter = "^$";
    };

    claude-code = {
      enable = true;
      # package = inputs.unstable.${system}.claude-code;

      mcpServers = {
        fetch = {
          args = ["-y" "@modelcontextprotocol/server-fetch"];
          command = "npx";
          type = "stdio";
        };
        playwright = {
          args = ["-y" "@modelcontextprotocol/server-playwright"];
          command = "npx";
          type = "stdio";
        };
        stackexchange = {
          args = ["-y" "mcp-server-stackexchange"];
          command = "npx";
          type = "stdio";
        };
        arxiv = {
          args = ["-y" "mcp-server-arxiv"];
          command = "npx";
          type = "stdio";
        };
        claudezilla = {
          command = "bun";
          args = ["/home/toph/code/vendor/claudezilla/mcp/server.js"];
          type = "stdio";
        };
      };
    };
  };
}

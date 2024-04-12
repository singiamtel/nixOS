{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Development
    nodejs
    atuin
    nodejs.pkgs.pnpm
    bun
    lazygit
    rustc
    rustfmt
    cargo
    clippy
    diesel-cli
    clang
    gcc
    alejandra # .nix linter
    nix-prefetch-git
    jdk17
    python3
    flyctl
    sqlite
    gimp
    flyctl
    parallel

    # CLI
    fzf
    xclip
    bat
    jq
    neofetch
    vim
    wget
    git
    libnotify
    tmux
    gh
    ranger
    ffmpeg
    zx
    gdu
    bottom
    magic-wormhole
    htop

    # busybox
    #eza
    ripgrep
    neovide
    byobu
    screen
    glxinfo
    vulkan-tools

    # Games
    lutris
    gnome3.adwaita-icon-theme
    prismlauncher

    # Desktop apps
    thunderbird
    obsidian
    telegram-desktop
    spotify
    discord
    firefox
    # google-chrome
    bitwarden
    vscode.fhs
    kazam
    mpv
    ckb-next
    (appimageTools.wrapType1 {
      name = "Cursor";
      version = "16";

      src = fetchurl {
        url = "https://download.cursor.sh/linux/appImage/x64";
        sha256 = "sha256-FWKVmM+8NZ5EfV4ZbDPbho+2kfZZzut1h81sF8XM8fw=";
      };
    })
  ];
}

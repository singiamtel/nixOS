{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Development
    nodejs
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

    # busybox
    eza
    ripgrep
    neovide
    byobu
    screen
    warp-terminal
    glxinfo
    vulkan-tools

    # Games
    lutris
    gnome3.adwaita-icon-theme

    # Desktop apps
    thunderbird
    obsidian
    telegram-desktop
    spotify
    discord
    firefox
    google-chrome
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
        sha256 = "1jc2x0k5m4jhg1c46fzs3ds17d0xfrjd1519afkgk99wr0zxamvm";
      };
    })
  ];
}

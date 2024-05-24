{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Javascript
    nodejs
    nodejs.pkgs.pnpm
    bun

    alejandra
    nix-prefetch-git
    jdk17
    python3
    flyctl
    sqlite
    gimp
    parallel

    # CLI
    fzf
    lazygit
    xclip
    bat
    bc
    jq
    neofetch
    cloc
    vim
    wget
    git
    libnotify
    tmux
    gh
    ranger
    ffmpeg
    imagemagick
    zx
    gdu
    bottom
    magic-wormhole
    htop
    eza
    ripgrep
    neovide
    killall
    zip
    unzip
  ];
}

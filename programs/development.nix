{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Javascript
    nodejs
    nodejs.pkgs.pnpm
    bun

    clang
    gcc
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
    eza
    ripgrep
    neovide
    killall
  ];
}

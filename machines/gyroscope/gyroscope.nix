{
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = "gyroscope"; # Define your hostname.
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.autoUpgrade.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    ./hardware-configuration.nix
    ../../programs/desktop-apps.nix
    ../../programs/development.nix
    ../../programs/games.nix
    ../../programs/config/tmux.nix
    ../../programs/config/zsh.nix
  ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";

  services.xserver.enable = true;

  # Not KDE Plasma
  programs.hyprland.enable = true;

  console.keyMap = "uk";

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  users.users.sergio = {
    isNormalUser = true;
    description = "sergio";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [zsh bash];

  environment = {
    variables.EDITOR = "nvim";
    localBinInPath = true;
  };

  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  environment.systemPackages = with pkgs; [
  ];
}

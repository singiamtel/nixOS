{
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = "timeless"; # Define your hostname.
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
    ./nvidia.nix
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

  # KDE Plasma
  services.displayManager = {
    sddm.enable = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver = {
    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  #services.xserver = {
  #  layout = "gb";
  #  xkbVariant = "";
  #};

  console.keyMap = "uk";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  hardware.ckb-next.enable = true;

  users.users.sergio = {
    isNormalUser = true;
    description = "sergio";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      ckb-next
      kazam
      spotify
      discord
      thunderbird
      bruno
      obsidian
      telegram-desktop
      google-chrome
      lyrebird
      vscode.fhs
      bitwarden
      kazam
      element-desktop
      mpv
      ckb-next
      (appimageTools.wrapType1 {
        name = "Cursor";
        version = "16";

        src = fetchurl {
          # This sucks, why do they not provide a versioned URL?
          url = "https://download.cursor.sh/linux/appImage/x64";
          sha256 = "sha256-AZpMrtRaDTd72TgSmkN2irMIuC7LgZ4rpBK8+vApcq0=";
        };
      })
    ];
  };

  # environment.shells = with pkgs; [zsh bash];

  environment = {
    variables.EDITOR = "nvim";
    localBinInPath = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.jellyfin = {
    enable = true;
    user = "sergio";
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  networking.firewall.allowedTCPPorts = [22 3000 8000 80 443 25565 8096];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

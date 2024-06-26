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
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  imports = [
    ./hardware-configuration.nix
    ../../programs/desktop-apps.nix
    ../../programs/development.nix
    ../../programs/config/tmux.nix
    ../../programs/config/zsh.nix
  ];

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";

  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "fill";
    };
    #videoDrivers = ["qxl"];

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;

      # AARCH64: For now, on Apple Silicon, we must manually set the
      # display resolution. This is a known issue with VMware Fusion.
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 200 40
      '';
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
      ];
    };
    layout = "us";
    dpi = 150;
  };

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
    packages = with pkgs; [
      (appimageTools.wrapType1 {
        name = "Cursor";
        version = "16";

        src = fetchurl {
          url = "https://download.cursor.sh/linux/appImage/x64";
          sha256 = "sha256-AZpMrtRaDTd72TgSmkN2irMIuC7LgZ4rpBK8+vApcq0=";
        };
      })
    ];
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
    konsole
  ];
}

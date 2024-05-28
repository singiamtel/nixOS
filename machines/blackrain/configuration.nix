{
  modulesPath,
  lib,
  pkgs,
  config,
  ...
}: let
  rootPath = ../..;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = false;
    };
    grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.useDHCP = lib.mkDefault true;
  environment.systemPackages = with pkgs; [
    vim
    git
    nodejs
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  users.users.root = {
    openssh.authorizedKeys.keyFiles = [
      "${rootPath}/files/keys/id_rsa.starforsaken.pub"
    ];
  };

  users.users.blackrain = {
    isNormalUser = true;
    linger = true;
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keyFiles = [
      "${rootPath}/files/keys/id_rsa.starforsaken.pub"
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [22 80 443 8096];
    allowedUDPPorts = [53 51820];
  };
  services.fail2ban = {
    enable = true;
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "336h"; # 2 weeks
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  networking.hostName = "blackrain";
  networking.domain = "";
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";

  services.transmission = {
    user = "blackrain";
    enable = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0";
      download-dir = "/media/Downloads";
      rpc-whitelist = "127.0.0.1,192.168.1.122";
    };
  };

  services.tailscale.enable = true;

  services.jellyfin = {
    enable = true;
    user = "blackrain";
  };

  services.logind.lidSwitch = "ignore";
}

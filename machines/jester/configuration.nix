{
  modulesPath,
  lib,
  pkgs,
  ...
}: let
  rootPath = ../..;
in {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  networking.useDHCP = lib.mkDefault true;
  environment.systemPackages = with pkgs; [
    vim
    git
    nodejs
  ];

  users.users.root = {
    openssh.authorizedKeys.keyFiles = [
      "${rootPath}/files/keys/id_rsa.starforsaken.pub"
    ];
  };

  users.users.jester = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keyFiles = [
      "${rootPath}/files/keys/id_rsa.starforsaken.pub"
    ];
  };
  # Define user-specific systemd service
  systemd.user.services.roomba = {
    enable = true;
    description = "pm2";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node ~/servers/PS-Bot/dist/main.js";
      # ExecStop = "${pkgs.nodejs}/bin/node kill";
      Type = "simple";
    };
  };

  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";
}

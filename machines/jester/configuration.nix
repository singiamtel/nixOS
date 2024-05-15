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
  networking.useDHCP = lib.mkDefault true;
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  users.users.jester = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keyFiles = [
      "${rootPath}/files/keys/id_rsa.starforsaken.pub"
    ];
  };

  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";
}

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
    linger = true;
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keyFiles = [
      "${rootPath}/files/keys/id_rsa.starforsaken.pub"
    ];
  };
  # Define user-specific systemd service
  systemd.user.services.roomba = {
    enable = true;
    description = "PS bot";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node servers/PS-Bot/dist/main.js";
      # ExecStop = "pkill -f 'node servers/PS-Bot/dist/main.js'";
      Type = "simple";
    };
  };

  systemd.user.services.crobat = {
    enable = true;
    description = "Crob.at homepage";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node servers/crob.at/dist/index.js";
      # ExecStop = "pkill -f 'node servers/crob.at/dist/main.js'";
      Type = "simple";
    };
  };

  services.caddy = {
    enable = true;
    extraConfig = ''
      crob.at/roomba* {
          reverse_proxy localhost:13337
      }

      crob.at {
          reverse_proxy localhost:3000
      }

      cdn.crob.at {
          file_server {
            root /var/www/crob.at
            browse
          }
      }
    '';
  };
  networking.firewall.allowedTCPPorts = [80 443];
  services.fail2ban = {
    enable = true;
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      # formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";
}

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
      Type = "simple";
      RuntimeMaxSec = "6h";
      Restart = "always";
    };
  };

  systemd.user.services.crobat = {
    enable = true;
    description = "Crob.at homepage";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node servers/crob.at/dist/index.js";
      Type = "simple";
    };
  };

  services.caddy = {
    enable = true;

    configFile = pkgs.writeText "Caddyfile" ''
      {
        log {
          output file /var/log/caddy/caddy.log {
            roll_size 5MiB
              roll_keep_for 720h # 30 days
          }
          format json {
            time_format iso8601
          }
        }
      }

      crob.at {
        handle_path /roomba* {
          reverse_proxy localhost:13337 {
            header_down Location ^/ /roomba/{http.response.header.Location}
          }
        }

        handle_path /home* {
          reverse_proxy localhost:54321 {
            header_down Location ^/ /home/{http.response.header.Location}
          }
        }

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
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "336h"; # 2 weeks
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  virtualisation.docker.enable = true;
  system.stateVersion = "23.11";
}

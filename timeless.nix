{
  config,
  pkgs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  # trace: warning: The option `services.xserver.xkbVariant' defined in `/etc/nixos/configuration.nix' has been renamed to `services.xserver.xkb.variant'.
  # trace: warning: The option `services.xserver.layout' defined in `/etc/nixos/configuration.nix' has been renamed to `services.xserver.xkb.layout'.

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  programs.zsh.enable = true;
  users.users.sergio = {
    isNormalUser = true;
    description = "sergio";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
  };
  home-manager.users.sergio = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    home.packages = [
      (pkgs.writeTextFile {
        name = "cursor-desktop-entry";
        destination = "/share/applications/cursor.desktop";
        text = ''
          [Desktop Entry]
          Version=1.0
          Type=Application
          Name=Cursor
          Exec=/run/current-system/sw/bin/Cursor
          Icon=cursor-icon
          Terminal=false
          Categories=Utility;
        '';
      })
    ];
    programs.bash.enable = true;
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        yzhang.markdown-all-in-one
        formulahendry.auto-rename-tag
        #steoates.autoimport
        aaron-bond.better-comments
        ms-python.black-formatter
        naumovs.color-highlight
        #janisdd.vscode-edit-csv
        bradlc.vscode-tailwindcss
        #vue.volar
        dbaeumer.vscode-eslint
      ];
    };
    # Enable zsh
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo" "z"];
        theme = "ys";
      };
      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
            hash = "sha256-0/YOL1/G2SWncbLNaclSYUz7VyfWu+OB8TYJYm4NYkM=";
          };
        }
        {
          name = "zsh-fzf-history-search";
          src = pkgs.fetchFromGitHub {
            owner = "joshskidmore";
            repo = "zsh-fzf-history-search";
            rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
            hash = "sha256-0/YOL1/G2SWncbLNaclSYUz7VyfWu+OB8TYJYm4NYkM=";
          };
        }
        {
          name = "zsh-autoswitch-virtualenv";
          src = pkgs.fetchFromGitHub {
            owner = "MichaelAquilina";
            repo = "zsh-autoswitch-virtualenv";
            rev = "4ddc42d3d84bfb36fac1eb48e9e6de33a92fa4f1";
            hash = "sha256-hwg9wDMU2XqJ5FQEwMVVaz0n+xZ8NI82tH9VhLfFRC4=";
          };
        }
      ];

      initExtra = ''
        export KEYTIMEOUT=1
        bindkey -v
        bindkey '^e' edit-command-line
        # bindkey -M viins '^R' fzf_history_search
        bindkey "^?" backward-delete-char
      '';
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
               set undofile
               set undodir=~/.vim/undodir
        set clipboard^=unnamed,unnamedplus
      '';
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    jdk17
    firefox
    kate
    pkgs.bitwarden
    thunderbird
    discord
    neofetch
    obsidian
    alejandra
    ckb-next
    telegram-desktop
    libnotify
    spotify
    nix-prefetch-git
    xclip
    nodejs
    lazygit

    # games
    lutris
    gnome3.adwaita-icon-theme

    # shell
    fzf
    (appimageTools.wrapType1 {
      name = "Cursor";
      version = "16";

      src = fetchurl {
        url = "https://download.cursor.sh/linux/appImage/x64";
        sha256 = "08q8lrs8bgyjpwvxswxix2m6n24k6zzbsqwnbachdf16b3l4c4iy";
      };
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.ckb-next.enable = true;

  environment.variables.EDITOR = "nvim";
  environment.localBinInPath = true;
}

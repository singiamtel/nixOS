{pkgs, ...}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    thunderbird
    obsidian
    telegram-desktop
    spotify
    discord
    firefox
    google-chrome
    bitwarden
    vscode.fhs

    mpv
    (appimageTools.wrapType1 {
      name = "Cursor";
      version = "16";

      src = fetchurl {
        url = "https://download.cursor.sh/linux/appImage/x64";
        sha256 = "sha256-FWKVmM+8NZ5EfV4ZbDPbho+2kfZZzut1h81sF8XM8fw=";
      };
    })
  ];
}

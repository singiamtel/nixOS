{
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
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.05";
  };
}

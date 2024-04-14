{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nvim
  ];
  #nixpkgs.config.allowUnfree = true;
  home = {
    username = "sergio";
    homeDirectory = "/home/sergio";
    packages = [
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
    stateVersion = "23.11";
  };
  # programs.atuin = {
  #   enable = true;
  # };

  programs.home-manager.enable = true;
}

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
    packages = with pkgs; [
      (writeTextFile {
        name = "cursor-desktop-entry";
        destination = "/share/applications/cursor.desktop";
        # This also sucks, idk how to get the binary path
        text = ''
          [Desktop Entry]
          Version=1.0
          Type=Application
          Name=Cursor
          Exec=/etc/profiles/per-user/sergio/bin/Cursor
          Icon=cursor-icon
          Terminal=false
          Categories=Utility;
        '';
      })
      deluge
      transmission_4-qt
    ];
    stateVersion = "23.11";
  };
  # programs.atuin = {
  #   enable = true;
  # };

  programs.home-manager.enable = true;
}

{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    ohMyZsh = {
      enable = true;
      customPkgs = [
        pkgs.nix-zsh-completions
      ];

      plugins = [
        "git"
        "sudo"
        "z"
      ];
      theme = "ys";
    };
  };
  environment.interactiveShellInit = ''
    alias lg='lazygit'
    alias -g G='| grep -Ei'
    alias vim='nvim'
    alias r='ranger'
    alias ka='killall'
    alias sdn='sudo poweroff'

    bindkey -v
    KEYTIMEOUT=1

    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

    setopt extended_history
  '';
  users.defaultUserShell = pkgs.zsh;
  programs.direnv.enable = true;
}

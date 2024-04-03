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
        pkgs.zsh-fzf-history-search
      ];

      plugins = [
        "git"
        "sudo"
        "z"
        # pkgs.nix-zsh-completions
        # pkgs.zsh-fzf-tab
        # pkgs.zsh-fzf-history-search
      ];
      theme = "ys";
    };
  };
  environment.interactiveShellInit = ''
        alias lg='lazygit'
        alias -g G='| grep -Ei'
        alias b='byobu-tmux'
        alias e='nvim'
        alias v='nvim'
        alias r='ranger'
        # bindkey -M viins '^R' fzf_history_search
        bindkey -v
          source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
          source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    KEYTIMEOUT=1
  '';
  users.defaultUserShell = pkgs.zsh;
}

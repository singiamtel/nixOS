{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    ohMyZsh = {
      customPkgs = [
        pkgs.nix-zsh-completions
        pkgs.zsh-fzf-history-search
      ];
    };
    oh-my-zsh = {
      enable = true;
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
  '';
  users.defaultUserShell = pkgs.zsh;
}

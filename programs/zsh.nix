{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    ohMyZsh = {
      customPkgs = [
        pkgs.nix-zsh-completions
        pkgs.zsh-fzf-tab
        pkgs.zsh-fzf-history-search
      ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
        "nix-zsh-completions"
        "zsh-fzf-tab"
        "zsh-fzf-history-search"
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
    bindkey -M viins '^R' fzf_history_search
  '';
  users.defaultUserShell = pkgs.zsh;
}

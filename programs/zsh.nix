{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
        "fzf-tab"
        "zsh-fzf-history-search"
        "zsh-autoswitch-virtualenv"

        # {
        #   name = "fzf-tab";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "Aloxaf";
        #     repo = "fzf-tab";
        #     rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
        #     hash = "sha256-0/YOL1/G2SWncbLNaclSYUz7VyfWu+OB8TYJYm4NYkM=";
        #   };
        # }
        # {
        #   name = "zsh-fzf-history-search";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "joshskidmore";
        #     repo = "zsh-fzf-history-search";
        #     rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
        #     hash = "sha256-0/YOL1/G2SWncbLNaclSYUz7VyfWu+OB8TYJYm4NYkM=";
        #   };
        # }
        # {
        #   name = "zsh-autoswitch-virtualenv";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "MichaelAquilina";
        #     repo = "zsh-autoswitch-virtualenv";
        #     rev = "4ddc42d3d84bfb36fac1eb48e9e6de33a92fa4f1";
        #     hash = "sha256-hwg9wDMU2XqJ5FQEwMVVaz0n+xZ8NI82tH9VhLfFRC4=";
        #   };
        # }
      ];
      theme = "ys";
    };
    # plugins = [
    # ];
  };
  users.defaultUserShell = pkgs.zsh;
}

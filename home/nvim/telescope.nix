{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>fw" = "live_grep";
      "<C-p>" = {
        action = "git_files";
        options.desc = "Telescope Git Files";
      };

      "<leader>ff" = {
        action = "find_files";
        options.desc = "Telescope Find Files";
      };
    };
    extensions.fzf-native = {enable = true;};
  };
}

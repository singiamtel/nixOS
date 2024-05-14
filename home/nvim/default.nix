{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./cmp.nix
    ./colorizer.nix
    ./copilot.nix
    ./git.nix
    ./keymaps.nix
    ./lsp.nix
    ./options.nix
    ./telescope.nix
    ./treesitter.nix
    ./whichkey.nix
    ./wilder.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings.flavour = "mocha";
    # colorschemes.catppuccin.transparentBackground = true;

    opts = {
      formatoptions = "qlnj";
      wrap = false;
    };
    plugins = {
      lualine.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip = {
        enable = true;
      };
      comment.enable = true;
      surround.enable = true;
      auto-session.enable = true;
      fugitive.enable = true;
      nvim-tree.enable = true;

      alpha = {
        enable = true;
        theme = "dashboard";
      };
      bufferline.enable = true;

      # nvim-cmp = {
      #   enable = true;
      #   autoEnableSources = true;
      #   sources = [
      #     {name = "nvim_lsp";}
      #     {name = "path";}
      #     {name = "buffer";}
      #   ];
      # };
    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-snippets
    ];
    extraConfigLuaPre = ''
      luasnip = require("luasnip")
      require("luasnip.loaders.from_snipmate").lazy_load()
    '';
    keymaps = [
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<CR>";
      }
    ];
  };
}

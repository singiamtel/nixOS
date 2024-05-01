{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    #./bufferline.nix
    ./telescope.nix
    # ./nvim-tree.nix
    # ./lightline.nix
    ./git.nix
    ./cmp.nix
    # ./none-ls.nix
    ./wilder.nix
    ./lsp.nix
    ./treesitter.nix
    # ./toggleterm.nix
    ./copilot.nix
    # ./obsidian.nix
    ./whichkey.nix
    # ./alpha.nix
    ./keymaps.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings.flavour = "mocha";
    # colorschemes.catppuccin.transparentBackground = true;

    opts = {
      formatoptions = "qlnj";
    };
    plugins = {
      lualine.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      commentary.enable = true;
      surround.enable = true;

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
    keymaps = [
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<CR>";
      }
    ];
  };
}

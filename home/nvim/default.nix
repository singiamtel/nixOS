{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    #./options.nix
    #./bufferline.nix
    # ./telescope.nix
    # ./nvim-tree.nix
    # ./lightline.nix
    # ./git.nix
    # ./cmp.nix
    # ./none-ls.nix
    # ./wilder.nix
    # ./lsp.nix
    # ./treesitter.nix
    # ./toggleterm.nix
    # ./copilot.nix
    # ./obsidian.nix
    # ./whichkey.nix
    # ./alpha.nix
    # ./keymaps.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.flavour = "latte";
    # colorschemes.catppuccin.transparentBackground = true;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;

      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua-ls.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };

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
  };
}

{
  programs.nixvim.keymaps = [
    {
      key = "<leader>e";
      action = "<CMD>Neotree toggle<CR>";
    }
    {
      key = "<F2>";
      action = "<CMD>lua vim.lsp.buf.rename()<CR>";
    }
    {
      key = "<space>fm";
      action = "<CMD>lua vim.lsp.buf.format()<CR>";
    }

    {
      key = "<leader>ot";
      action = "<cmd>lua require('obsidian').util.toggle_checkbox()<cr>";
    }

    {
      key = "<leader>oo";
      action = "<cmd>ObsidianQuickSwitch<cr>";
    }

    {
      key = "<leader>on";
      action = "<cmd>ObsidianNew<cr>";
    }

    {
      key = "<leader>of";
      action = "<cmd>ObsidianSearch<cr>";
    }

    {
      key = "<leader>oi";
      action = "<cmd>ObsidianPasteImg<cr>";
    }

    {
      mode = "n";
      key = "<c-n>";
      action = "<cmd>NvimTreeToggle<cr>";
    }

    {
      mode = "n";
      key = "<leader>gt";
      action = "<cmd>bn<cr>";
    }

    {
      mode = "n";
      key = "<leader>gT";
      action = "<cmd>bp<cr>";
    }
  ];
}

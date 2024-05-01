{
  programs.nixvim.plugins.lsp = {
    enable = true;
    keymaps = {
      lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
    servers = {
      tsserver.enable = true;
      lua-ls.enable = true;
      pyright.enable = true;
      clangd.enable = true;
      nil_ls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };
}

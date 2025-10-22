return {
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "clangd",
          "cmake",
          "cssls",
          "vtsls",
          "rust_analyzer",
        },
      })
    end,
  },
}

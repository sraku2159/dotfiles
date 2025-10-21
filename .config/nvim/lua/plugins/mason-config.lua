require("mason").setup()
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

-- 診断メッセージを行の下に表示
vim.diagnostic.config({
  virtual_text = false, -- 行末の表示を無効化
  virtual_lines = true, -- 行の下に表示（Neovim 0.11以降）
})

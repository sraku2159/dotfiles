-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("n", ",", "<Plug>(customPrefix)", { silent = true })

keymap.set("t", "<C-[>", "<C-\\><C-n>")

-- エクスプローラの検索バーにカーソルが残ってしまっている問題を解決する

vim.api.nvim_create_user_command("LspRestart", function()
  for _, client in ipairs(vim.lsp.get_clients()) do
    client:stop()
  end
  vim.defer_fn(function()
    vim.cmd("edit")
  end, 500)
end, { desc = "Restart all LSP clients" })

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 診断メッセージを行の下に表示
vim.diagnostic.config({
  virtual_text = false, -- 行末の表示を無効化
  virtual_lines = true, -- 行の下に表示（Neovim 0.11以降）
})

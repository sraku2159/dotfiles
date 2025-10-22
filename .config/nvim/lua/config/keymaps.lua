-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("n", ",", "<Plug>(customPrefix)", { silent = true })

keymap.set("t", "<C-[>", "<C-/><C-n>")

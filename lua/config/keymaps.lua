-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- vim.keymap.del("i", "<c-k>")

map("i", "jk", "<esc>", opts)

map("i", "<c-h>", "<left>", opts)
map("i", "<c-j>", "<down>", opts)
map("i", "<c-k>", "<up>", opts)
map("i", "<c-l>", "<right>", opts)

map("n", "<c-d>", "<c-d>zz", opts)
map("n", "<c-u>", "<c-u>zz", opts)

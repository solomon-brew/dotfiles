-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader to ";"
-- set("n", ";", "", opts)

-- Select all
set("n", "<C-a>", "gg<S-v>G")

-- Exit insert mode pressing 'jj'
set("i", "kj", "<ESC>")

-- Use H and L to go to beggining/end of the line
set("o", "H", "^", opts)
set("o", "L", "$", opts)

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")

local map = vim.keymap.set

map("n", "<Esc>/", function()
  Util.terminal(nil, { cwd = Util.root() })
end, { desc = "Toggle Terminal" })

map("t", "<Esc>/", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  Util.terminal(nil, { cwd = Util.root() })
end, { desc = "Toggle Terminal" })

-- map("n", "<C-h>", "<C-w><", { desc = "Decrease window width" })
-- map("n", "<C-l>", "<C-w>>", { desc = "Increase window width" })
-- map("n", "<C-j>", "<C-w>+", { desc = "Increase window height" })
-- map("n", "<C-k>", "<C-w>-", { desc = "Decrease window height" })

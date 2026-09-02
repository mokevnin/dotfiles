-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local bind = vim.keymap.set
local opts = { silent = true, noremap = true }
--
-- -- for russian layout
-- буквенные маппинги (в т.ч. LazyVim'ские j/k -> gj/gk) переводит langmapper,
-- руками остаются только Ctrl-комбинации в insert: langmapper по умолчанию не
-- хакает insert-режим, а нам нужен именно вариант с разрывом undo (<C-G>u)
bind("i", "<c-х>", "<C-[>", opts)
bind("i", "<C-г>", "<C-G>u<C-U>", opts)
bind("i", "<C-ц>", "<C-G>u<C-W>", opts)
--
-- bind("n", "[c", function()
--   require("treesitter-context").go_to_context()
-- end)
--
bind(
  "n",
  "<leader>[",
  "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
  vim.tbl_extend("force", opts, { desc = "Add blank line above" })
)
bind(
  "n",
  "<leader>]",
  "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
  vim.tbl_extend("force", opts, { desc = "Add blank line below" })
)
--
-- vim.keymap.set("n", "<leader>fj", ":Neotree reveal<CR>", {})
-- vim.keymap.set('n', '<leader>fa', ':Telescope telescope-alternate alternate_file<CR>', {})

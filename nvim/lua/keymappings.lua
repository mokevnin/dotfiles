local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

keymap('n', '<leader>vr', ':so $MYVIMRC<CR>')

-- Better window movement
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

keymap("n", "gV", "`[v`]", opts)

keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)

-- for russian layout
keymap("n", "л", "gk", opts)
keymap("n", "о", "gj", opts)

-- Move selected line / block of text in visual mode
-- keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

keymap('v', '"y', '"*y', opts)
keymap('n', '"y', '"*y', opts)
keymap('n', '"Y', '"*Y', opts)
keymap('n', '"p', '"*p', opts)
keymap('n', '"P', '"*P', opts)

-- Save file by CTRL-S
-- keymap("n", "<C-s>", ":w<CR>", silent)
-- keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Buffers
keymap("n", "gn", ":bn<CR>", opts)
keymap("n", "gp", ":bp<CR>", opts)

-- Don't yank on delete char
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)
keymap("v", "x", '"_x', opts)
keymap("v", "X", '"_X', opts)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', opts)

-- Quickfix
-- keymap("n", "<leader>,", ":cp<CR>", silent)
-- keymap("n", "<leader>.", ":cn<CR>", silent)

-- Toggle quicklist
-- https://github.com/ecosse3/nvim/blob/master/lua/utils/init.lua
-- keymap("n", "<leader>q", "<cmd>lua require('utils').toggle_quicklist()<CR>", silent)

-- Easyalign
-- keymap("n", "ga", "<Plug>(EasyAlign)", silent)
-- keymap("x", "ga", "<Plug>(EasyAlign)", silent)

-- Refactor with spectre
keymap("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opts)
keymap("v", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>")

-- Comment Box
keymap("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", opts)
keymap("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", opts)

-- LSP
-- partially implemented in zero-lsp

keymap(
  "v",
  "<leader>rr",
  "<Esc><rmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  opts
)

keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
keymap('n', '<leader>q', "<cmd>TroubleToggle loclist<cr>", opts)

-- keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
-- keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting({ async = true })<CR>", opts)
-- keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", opts)
-- keymap("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
-- keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", options)
-- keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", options)

-- Telescope
-- keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)
-- keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<leader>sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
keymap("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
keymap("n", "<leader>sc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", opts)
keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
keymap("n", "<leader>so", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
keymap("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
--
keymap('n', '<leader><leader>', ':NvimTreeToggle<CR>')

keymap('n', '<C-n>', ':NvimTreeFindFile<CR>')
--
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "gR", "<cmd>TroubleToggle<cr>", opts)

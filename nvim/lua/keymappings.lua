local bind = vim.keymap.set
local opts = { silent = true, noremap = true }

bind("n", "<leader>h", ":nohlsearch<CR>", opts)

bind('n', '<leader>vr', ':so $MYVIMRC<CR>')

-- Better window movement
bind("n", "<C-l>", "<C-w>l", opts)
bind("n", "<C-h>", "<C-w>h", opts)
bind("n", "<C-j>", "<C-w>j", opts)
bind("n", "<C-k>", "<C-w>k", opts)

bind("n", "gV", "`[v`]", opts)

bind("n", "k", "gk", opts)
bind("n", "j", "gj", opts)

-- for russian layout
bind("n", "л", "gk", opts)
bind("n", "о", "gj", opts)

-- Move selected line / block of text in visual mode
-- keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

bind('v', '"y', '"*y', opts)
bind('n', '"y', '"*y', opts)
bind('n', '"Y', '"*Y', opts)
bind('n', '"p', '"*p', opts)
bind('n', '"P', '"*P', opts)

-- Save file by CTRL-S
-- keymap("n", "<C-s>", ":w<CR>", silent)
-- keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Buffers
bind("n", "gn", ":bn<CR>", opts)
bind("n", "gp", ":bp<CR>", opts)

-- Don't yank on delete char
bind("n", "x", '"_x', opts)
bind("n", "X", '"_X', opts)
bind("v", "x", '"_x', opts)
bind("v", "X", '"_X', opts)

-- Don't yank on visual paste
bind("v", "p", '"_dP', opts)

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
bind("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", opts)
bind("v", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>")

-- Comment Box
bind("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", opts)
bind("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", opts)

-- LSP
-- partially implemented in zero-lsp

bind(
  "v",
  "<leader>rr",
  "<Esc><rmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  opts
)

bind('n', '<leader>e', vim.diagnostic.open_float, opts)
bind('n', '<leader>q', "<cmd>TroubleToggle<cr>", opts)
-- conflict with zero-lsp default keybindings
-- keymap('n', "gr", "<cmd>TroubleToggle quickfix<cr>", opts)
bind('n', "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)

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
bind("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
bind("n", "<leader>sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
bind("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
bind("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
bind("n", "<leader>sc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", opts)
bind("n", "<leader>sr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
bind("n", "<leader>so", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
bind("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
--
bind('n', '<leader><leader>', ':NvimTreeToggle<CR>')

bind('n', '<C-n>', ':NvimTreeFindFile<CR>')

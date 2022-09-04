local keymap = vim.keymap.set
local options = { silent = true }

keymap("n", "<leader>h", ":nohlsearch<CR>", options)

keymap('n', '<leader>vr', ':so $MYVIMRC<CR>')

-- Better window movement
keymap("n", "<C-l>", "<C-w>l", options)
keymap("n", "<C-h>", "<C-w>h", options)
keymap("n", "<C-j>", "<C-w>j", options)
keymap("n", "<C-k>", "<C-w>k", options)

keymap("n", "gV", "`[v`]", options)

keymap("n", "k", "gk", options)
keymap("n", "j", "gj", options)

-- for russian layout
keymap("n", "л", "gk", options)
keymap("n", "о", "gj", options)

-- Move selected line / block of text in visual mode
-- keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

keymap('v', '"y', '"*y', options)
keymap('n', '"y', '"*y', options)
keymap('n', '"Y', '"*Y', options)
keymap('n', '"p', '"*p', options)
keymap('n', '"P', '"*P', options)

-- Save file by CTRL-S
-- keymap("n", "<C-s>", ":w<CR>", silent)
-- keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Buffers
keymap("n", "gn", ":bn<CR>", options)
keymap("n", "gp", ":bp<CR>", options)

-- Don't yank on delete char
keymap("n", "x", '"_x', options)
keymap("n", "X", '"_X', options)
keymap("v", "x", '"_x', options)
keymap("v", "X", '"_X', options)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', options)

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
keymap("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", options)
keymap("v", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>")

-- LSP
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", options)
-- keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)
keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", options)
keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", options)
keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting({ async = true })<CR>", options)
keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", options)
keymap("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", options)
keymap("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", options)
keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", options)

-- Comment Box
keymap("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", options)
keymap("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", options)

-- Telescope
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", options)
keymap("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
keymap("n", "<leader>sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", options)
keymap("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
keymap("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", options)
keymap("n", "<leader>sc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", options)
keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", options)
keymap("n", "<leader>so", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", options)
keymap("n", "<leader>sa", "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>", options)
keymap("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", options)
--
keymap('n', '<leader><leader>', ':NvimTreeToggle<CR>')
-- nnoremap <leader><leader> :NvimTreeToggle<CR>
keymap('n', '<C-n>', ':NvimTreeFindFile<CR>')
-- nnoremap <C-n> :NvimTreeFindFile<CR>
--
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)

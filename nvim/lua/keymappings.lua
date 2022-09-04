local keymap = vim.keymap.set
local silent = { silent = true }

keymap("n", "<leader>h", ":nohlsearch<CR>", silent)

keymap('n', '<leader>vr', ':so $MYVIMRC<CR>')

-- Better window movement
keymap("n", "<C-l>", "<C-w>l", silent)
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)

keymap("n", "gV", "`[v`]", silent)

keymap("n", "k", "gk", silent)
keymap("n", "j", "gj", silent)

-- for russian layout
keymap("n", "л", "gk", silent)
keymap("n", "о", "gj", silent)

-- Move selected line / block of text in visual mode
-- keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

-- Keep visual mode indenting
keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

-- Save file by CTRL-S
-- keymap("n", "<C-s>", ":w<CR>", silent)
-- keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Buffers
keymap("n", "gn", ":bn<CR>", silent)
keymap("n", "gp", ":bp<CR>", silent)

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

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
keymap("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", silent)
keymap("v", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>")

-- LSP
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)
-- keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent)
keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting({ async = true })<CR>", silent)
keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
keymap("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
keymap("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)

-- Comment Box
keymap("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", silent)
keymap("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", silent)

-- Telescope
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", silent)
keymap("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", silent)
keymap("n", "<leader>sb", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", silent)
keymap("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", silent)
keymap("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", silent)
keymap("n", "<leader>sc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", silent)
keymap("n", "<leader>sr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", silent)
keymap("n", "<leader>so", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", silent)
keymap("n", "<leader>sa", "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>", silent)
keymap("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", silent)
--
keymap('n', '<leader><leader>', ':NvimTreeToggle<CR>')
-- nnoremap <leader><leader> :NvimTreeToggle<CR>
keymap('n', '<C-n>', ':NvimTreeFindFile<CR>')
-- nnoremap <C-n> :NvimTreeFindFile<CR>
--
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)

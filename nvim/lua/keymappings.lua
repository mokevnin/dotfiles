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
bind("i", "<c-х>", "<C-[>", opts)
bind("n", "л", "gk", opts)
bind("n", "о", "gj", opts)
bind("i", "<C-г>", "<C-G>u<C-U>", opts)
bind("i", "<C-ц>", "<C-G>u<C-W>", opts)

-- Move selected line / block of text in visual mode
-- keymap("x", "K", ":move '<-2<CR>gv-gv", silent)
-- keymap("x", "J", ":move '>+1<CR>gv-gv", silent)

bind('v', '"y', '"+y', opts)
bind('n', '"y', '"+y', opts)
bind('n', '"Y', '"+Y', opts)
bind('n', '"p', '"+p', opts)
bind('n', '"P', '"+P', opts)

-- Save file by CTRL-S
-- keymap("n", "<C-s>", ":w<CR>", silent)
-- keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Buffers
bind("n", "gn", ":bn<CR>", opts)
bind("n", "gp", ":bp<CR>", opts)

-- Don't yank on delete char
-- bind("n", "x", '"_x', opts)
-- bind("n", "X", '"_X', opts)
-- bind("v", "x", '"_x', opts)
-- bind("v", "X", '"_X', opts)

-- Don't yank on visual paste
-- bind("v", "p", '"_dP', opts)

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

bind('n', '<leader>e', vim.diagnostic.open_float, opts)

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
bind('n', '<leader>q', "<cmd>lua require'qf'.toggle('l', true)<cr>", opts)
bind('n', "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)

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

bind('n', '[c', function()
  require('treesitter-context').go_to_context()
end)

bind("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
bind("n", "<leader>dk", "<cmd>lua require'dap'.continue()<cr>")
bind("n", "<leader>dt", "<cmd>lua require'dapui'.toggle()<cr>")
bind("n", "<leader>ds", "<cmd>lua require'dap'.disconnect({ terminateDebuggee = true })<cr>")

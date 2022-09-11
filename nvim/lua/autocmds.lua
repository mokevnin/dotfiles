-- Auto sync plugins on save of plugins.lua
-- vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 }) end })

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md" },
  command = "setlocal spell" })

-- augroup YankHighlight
--   autocmd!
--   autocmd TextYankPost * silent! lua vim.highlight.on_yank()
-- augroup end

vim.cmd [[
  augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    autocmd FileType ruby,eruby,yaml,javascript,typescript set ai sw=2 sts=2 et
    autocmd FileType java set ai sw=4 sts=4 et
  augroup END
]]

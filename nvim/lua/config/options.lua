-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.langmap =
  "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.o.relativenumber = false
vim.g.autoformat = false
-- vim.o.spell = false
vim.o.spelllang = "ru_ru,en_us"
-- vim.o.linebreak = true

vim.g.root_spec = { "cwd" }

-- vim.o.smartindent = false

vim.g.snacks_animate = false

vim.filetype.add({ extension = { jbuilder = "ruby" } })
vim.filetype.add({ extension = { rbi = "ruby" } })

-- vim.g.lazyvim_ts_lsp = "tsgo"

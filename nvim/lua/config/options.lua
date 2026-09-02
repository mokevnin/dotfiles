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

-- vim.g.root_spec = { "cwd" }

-- vim.o.smartindent = false

vim.g.snacks_animate = false

vim.filetype.add({ extension = { jbuilder = "ruby" } })
vim.filetype.add({ extension = { rbi = "ruby" } })

-- node/ruby hosts come from mise (npm:neovim / gem:neovim), not from a global npm/gem prefix
vim.g.node_host_prog = vim.fn.expand("~/.local/share/mise/installs/npm-neovim/latest/node_modules/neovim/bin/cli.js")
vim.g.ruby_host_prog = vim.fn.expand("~/.local/share/mise/shims/neovim-ruby-host")

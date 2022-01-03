-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- # https://github.com/wbthomason/packer.nvim

require('plugins')

vim.g.material_style = "deep ocean"

vim.diagnostic.config({
  virtual_text = {
    prefix = 'x'
  }
  -- signs = true,
  -- underline = true,
  -- update_in_insert = false,
  -- severity_sort = false,
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

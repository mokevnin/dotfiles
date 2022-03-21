-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/nanotee/nvim-lua-guide

-- https://github.com/nanotee/nvim-lua-guide#tips-2
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

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

require('plugins')

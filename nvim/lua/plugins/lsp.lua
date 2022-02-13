local M = {}

function M.run(use)
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }

  use 'kosayoda/nvim-lightbulb'
end

return M

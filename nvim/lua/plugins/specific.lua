local M = {}

function M.run(use)
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  --     use 'isobit/vim-caddyfile'
  use 'tpope/vim-rails'
  --     use 'slim-template/vim-slim'
  use 'dhruvasagar/vim-table-mode'
  use { 'mfussenegger/nvim-jdtls' }

end

return M

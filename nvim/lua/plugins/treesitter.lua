local M = {}

function M.run(use)
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
    'andymass/vim-matchup',
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    }
  }


  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        autotag = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        indent = {
          enable = true,
        },
        matchup = {
          enable = true
        },
      }
    end
  }
  -- use 'romgrk/nvim-treesitter-context'
end

return M

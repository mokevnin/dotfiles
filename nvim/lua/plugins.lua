require('packer').startup({

  function(use)
    use { 'tpope/vim-sensible' }
    use {
      'Pocco81/AutoSave.nvim',
      config = function ()
        local autosave = require("autosave")
        autosave.setup()
      end
    }

    use {
      'windwp/nvim-autopairs',
      config = function()
        local npairs = require('nvim-autopairs')
        npairs.setup({
          check_ts = true,
        })
        npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
        npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
        npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
      end
    }
    use 'tpope/vim-sleuth'
    use 'wbthomason/packer.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    use {
      'feline-nvim/feline.nvim',
      after = "nvim-web-devicons",
      config = function() require('feline').setup() end
    }
    -- use 'glepnir/dashboard-nvim'
    use 'tpope/vim-surround'
    use {
      'marko-cerovac/material.nvim'
    }

    use {
      'weilbith/nvim-code-action-menu',
      cmd = 'CodeActionMenu',
    }

    use { 'tpope/vim-unimpaired' }

    use {
      'terrortylor/nvim-comment',
      config = function() require('nvim_comment').setup() end
    }

    -- use { 'andymass/vim-matchup' }

    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        -- FIXME: enable sort_mru
        require('telescope').setup{
          defaults = {
            sorting_strategy = "ascending"
          },
          pickers = {
            buffers = {
              ignore_current_buffer = true,
              sort_mru = true
            }
          },
        }
      end,
      requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
      'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup({
          signs = {
            add = { hl = 'GitGutterAdd', text = '+' },
            change = { hl = 'GitGutterChange', text = '~' },
            delete = { hl = 'GitGutterDelete', text = '_' },
            topdelete = { hl = 'GitGutterDelete', text = '‾' },
            changedelete = { hl = 'GitGutterChange', text = '~' },
          },
        })
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
      config = function() require('nvim-tree').setup {} end
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)
    require('plugins.autocomplete').run(use)

  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
})

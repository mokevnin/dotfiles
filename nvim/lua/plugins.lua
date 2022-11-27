-- https://github.com/wbthomason/packer.nvim
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/ecosse3/nvim/blob/master/lua/plugins.lua

return require('packer').startup({

  function(use)

    use { 'wbthomason/packer.nvim' }
    use { 'slim-template/vim-slim' }

    -- speeding up
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }

    use { 'tpope/vim-sensible' }

    -- remove after releasing new version of neovim
    use { 'luukvbaal/stabilize.nvim' }

    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'svban/YankAssassin.vim' }

    -- TODO: add
    -- https://github.com/gbprod/yanky.nvim

    -- use {
    --   'rcarriga/nvim-notify',
    --   config = function()
    --     require("notify").setup({})
    --   end
    -- }

    use {
      'phaazon/hop.nvim',
      config = function()
        require 'hop'.setup()
      end
    }

    use {
      'goolord/alpha-nvim',
      config = function()
        require 'alpha'.setup(require 'alpha.themes.startify'.config)
      end
    }

    use {
      'akinsho/bufferline.nvim',
      config = function()
        require("bufferline").setup{}
      end,
      tag = "v2.*",
      requires = 'kyazdani42/nvim-web-devicons',
    }

    -- use {
    --   'gelguy/wilder.nvim',
    --   config = function()
    --     local wilder = require('wilder')
    --     wilder.setup({
    --       modes = {':', '/', '?'},
    --       next_key = '<C-n>',
    --       previous_key = '<C-p>',
    --     })
    --
    --     -- wilder.set_option('pipeline', {
    --     --   wilder.branch(
    --     --     wilder.cmdline_pipeline(),
    --     --     wilder.search_pipeline()
    --     --   ),
    --     -- })
    --
    --     -- wilder.set_option('renderer', wilder.renderer_mux({
    --     --   [':'] = wilder.popupmenu_renderer({
    --     --     highlighter = wilder.basic_highlighter(),
    --     --   }),
    --     --   ['/'] = wilder.wildmenu_renderer({
    --     --     highlighter = wilder.basic_highlighter(),
    --     --   }),
    --     -- }))
    --   end,
    -- }

    use { 'tpope/vim-fugitive' }
    use { 'LudoPinelli/comment-box.nvim' }
    use { 'AndrewRadev/splitjoin.vim' }

    use {
      'TimUntersberger/neogit',
      config = function()
        local neogit = require('neogit')
        neogit.setup()
      end,
      requires = 'nvim-lua/plenary.nvim'
    }

    use {
      'mfussenegger/nvim-dap',
      'jayp0521/mason-nvim-dap.nvim',
      config = function()
        require("dapui").setup()
      end
    }
    use {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require("nvim-dap-virtual-text").setup()
      end
    }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use { 'antoinemadec/FixCursorHold.nvim' }

    use 'tpope/vim-repeat'

    use {
      'kosayoda/nvim-lightbulb',
      requires = 'antoinemadec/FixCursorHold.nvim',
      config = function()
        local lightbulb = require('nvim-lightbulb')
        lightbulb.setup({ autocmd = { enabled = true } })
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons'
      },
      config = function()
        require('nvim-tree').setup {}
      end
    }

    use {
      'stevearc/dressing.nvim',
      config = function()
        -- TODO: add c-[ for normal mode
        -- https://github.com/stevearc/dressing.nvim/issues/29
        local dressing = require('dressing')
        dressing.setup({
          input = {
            get_config = function()
              if vim.api.nvim_buf_get_option(0, "filetype") == "NvimTree" then
                return { enabled = false }
              end
            end,
            -- mappings = {
            --   n = {
            --     ['C-['] = 'Close',
            --   },
            -- },
          },
          --   select = {
          --     telescope = {
          --       mappings = {
          --         n = {
          --           ['C-['] = 'Close',
          --         },
          --       },
          --     },
          --   },
        })
      end
    }

    use 'b0o/schemastore.nvim'

    use {
      'feline-nvim/feline.nvim',
      after = "nvim-web-devicons",
      config = function()
        require('feline').setup({
          -- preset = 'noicon'
        })
      end
    }

    use {
      'nvim-zh/auto-save.nvim',
      config = function()
        local autosave = require("auto-save")
        autosave.setup()
      end
    }

    use { 'ntpeters/vim-better-whitespace' }
    use 'tpope/vim-sleuth'

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('indent_blankline').setup {
          char = '┊',
          show_trailing_blankline_indent = false,
        }
      end
    }

    -- alternative https://github.com/machakann/vim-sandwich
    use { 'tpope/vim-surround' }
    use 'windwp/nvim-spectre'
    use 'dyng/ctrlsf.vim'
    use { 'marko-cerovac/material.nvim' }
    --
    use { 'tpope/vim-unimpaired' }

    use {
      'numToStr/Comment.nvim',
      config = function()
        local ts_comment_integration = require('ts_context_commentstring.integrations.comment_nvim')
        require('Comment').setup({
          pre_hook = ts_comment_integration.create_pre_hook(),
        })
      end
    }

    -- Lua
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

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup()
      end
    }
    --
    --     -- use {
    --     --   "beauwilliams/focus.nvim",
    --     --   config = function() require("focus").setup() end
    --     -- }
    --
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    require('plugins.null-ls.slim-lint')

    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)
    require('plugins.specific').run(use)

    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        local telescope = require('telescope')
        -- telescope.load_extension('fzf')
        telescope.load_extension('refactoring')

        local trouble = require("trouble.providers.telescope")

        telescope.setup {
          defaults = {
            sorting_strategy = "ascending",
            mappings = {
              -- restore default behavior
              i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ["<c-t>"] = trouble.open_with_trouble
              },
              n = {
                ["<c-t>"] = trouble.open_with_trouble
              }
            },
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

  end,

  config = {
    enable = true,
    -- log = { level = 'debug' },
    display = {
      open_fn = require('packer.util').float,
    }
  }
})

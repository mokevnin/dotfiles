-- https://github.com/wbthomason/packer.nvim
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/ecosse3/nvim/blob/master/lua/plugins.lua

return require('packer').startup({

  function(use)
    use { 'wbthomason/packer.nvim' }

    -- speeding up
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use {
      'goolord/alpha-nvim',
      config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
      end
    }

    use {
      'm-demare/hlargs.nvim',
      requires = { 'nvim-treesitter/nvim-treesitter' }
    }

    use{ 'LudoPinelli/comment-box.nvim' }

    use { 'AndrewRadev/splitjoin.vim' }

    use {
      'TimUntersberger/neogit',
      config = function()
        local neogit = require('neogit')
        neogit.setup()
      end,
      requires = 'nvim-lua/plenary.nvim'
    }

    use { 'tpope/vim-sensible' }

    use {
      'mfussenegger/nvim-dap',
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
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

    use { 'antoinemadec/FixCursorHold.nvim' }
    use { 'stevearc/dressing.nvim' }

    use 'tpope/vim-repeat'

    -- https://github.com/gelguy/wilder.nvim
    use { 'gelguy/wilder.nvim' }

    -- https://github.com/kevinhwang91/nvim-bqf
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

    use {
      'kosayoda/nvim-lightbulb',
      requires = 'antoinemadec/FixCursorHold.nvim',
      config = function()
        local lightbulb = require('nvim-lightbulb')
        lightbulb.setup({autocmd = {enabled = true}})
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
      config = function ()
        local autosave = require("auto-save")
        autosave.setup()
      end
    }

    use { 'ntpeters/vim-better-whitespace' }

    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {
      'danymat/neogen',
      config = function()
        require('neogen').setup {}
      end,
      requires = {
        'nvim-treesitter/nvim-treesitter'
      },
    }

    use {
      'windwp/nvim-autopairs',
      requires = {
        'hrsh7th/nvim-cmp',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        local npairs = require('nvim-autopairs')
        npairs.setup({
          -- check_ts = true
        })
        -- npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
        -- npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
        -- npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
      end
    }

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

    --     use 'isobit/vim-caddyfile'
    --     use 'tpope/vim-rails'
    --     use 'slim-template/vim-slim'
    use 'dhruvasagar/vim-table-mode'


      -- use {
      --   'jose-elias-alvarez/null-ls.nvim',
      --   config = function()
      --     local ls = require('null-ls')
      --     -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
      --     ls.setup({
      --       sources = {
      --         ls.builtins.formatting.stylua,
      --         -- ls.builtins.formatting.gofmt,
      --         -- ls.builtins.formatting.prettierd,
      --         -- ls.builtins.formatting.terraform_fmt,
      --         -- ls.builtins.formatting.uncrustify,
      --         -- ls.builtins.formatting.hadolint,
      --       },
      --     })
      --   end
      -- }

    -- alternative https://github.com/machakann/vim-sandwich
    use { 'tpope/vim-surround' }
    use 'windwp/nvim-spectre'
    use 'dyng/ctrlsf.vim'
    use { 'marko-cerovac/material.nvim' }
--
    use { 'tpope/vim-unimpaired' }

    use {
      'numToStr/Comment.nvim',
      config = function ()
        local ts_comment_integration = require('ts_context_commentstring.integrations.comment_nvim')
        require('Comment').setup({
          pre_hook = ts_comment_integration.create_pre_hook(),
        })
      end
    }

    use {
      'ThePrimeagen/refactoring.nvim',
      requires = {
        {'nvim-lua/plenary.nvim'},
        {'nvim-treesitter/nvim-treesitter'}
      }
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

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
      'nvim-telescope/telescope.nvim',
      config = function()
        local telescope = require('telescope')
        telescope.load_extension('refactoring')

        vim.api.nvim_set_keymap(
          "v",
          "<leader>rr",
          "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
          { noremap = true }
        )


        telescope.setup{
          defaults = {
            sorting_strategy = "ascending",
            mappings = {
              -- restore default behavior
              i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
              },
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

    require('plugins.treesitter').run(use)
    require('plugins.lsp').run(use)

    -- use {
    --   'williamboman/mason.nvim',
    --   config = function()
    --     require("mason").setup()
    --   end
    -- }

  end,

  config = {
    enable = true,
    -- log = { level = 'debug' },
    display = {
      open_fn = require('packer.util').float,
    }
  }
})

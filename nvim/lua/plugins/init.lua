-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/ecosse3/nvim/blob/master/lua/plugins.lua

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
    end
  },

  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',

      'folke/neodev.nvim',
      { 'j-hui/fidget.nvim', opts = {} },

      'mfussenegger/nvim-jdtls',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Null LS
      'jayp0521/mason-null-ls.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = require('plugins.lsp')
  },

  { 'tpope/vim-sensible' },

  { 'nvim-lua/plenary.nvim' },
  { 'kyazdani42/nvim-web-devicons' },
  { 'svban/YankAssassin.vim' },

  -- TODO: add
  -- https://github.com/gbprod/yanky.nvim

  -- use {
  --   'rcarriga/nvim-notify',
  --   config = function()
  --     require("notify").setup({})
  --   end
  -- }

  -- use {
  --   'ggandor/leap.nvim',
  --   config = function()
  --     local leap = require('leap')
  --     leap.add_default_mappings()
  --   end
  -- }
  -- use {
  --   'phaazon/hop.nvim',
  --   config = function()
  --     require 'hop'.setup()
  --   end
  -- }

  {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  },

  {
    'akinsho/bufferline.nvim',
    -- config = function()
    --   require("bufferline").setup {}
    -- end,
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    }
  },

  { 'tpope/vim-fugitive' },
  { 'LudoPinelli/comment-box.nvim' },

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    'ten3roberts/qf.nvim',
    -- config = function()
    --   require 'qf'.setup {}
    -- end
  },

  {
    'neogitorg/neogit',
    -- config = function()
    --   local neogit = require('neogit')
    --   neogit.setup()
    -- end,
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- {
  --   'mfussenegger/nvim-dap',
  --   'jayp0521/mason-nvim-dap.nvim',
  --   -- config = function()
  --   --   require("dapui").setup()
  --   -- end
  -- },
  --
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   config = function()
  --     require("nvim-dap-virtual-text").setup()
  --   end
  -- }
  -- { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  { 'antoinemadec/FixCursorHold.nvim' },

  { 'tpope/vim-repeat' },

  {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    config = function()
      local lightbulb = require('nvim-lightbulb')
      lightbulb.setup({ autocmd = { enabled = true } })
    end
  },

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require('nvim-tree').setup {}
    end
  },

  {
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
  },

  {
    'feline-nvim/feline.nvim',
    after = "nvim-web-devicons",
    config = function()
      require('feline').setup({
        -- preset = 'noicon'
      })
    end
  },

  {
    'nvim-zh/auto-save.nvim',
    config = function()
      local autosave = require("auto-save")
      autosave.setup()
    end
  },

  { 'ntpeters/vim-better-whitespace' },
  { 'tpope/vim-sleuth' },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        char = '┊',
        show_trailing_blankline_indent = false,
      }
    end
  },

  -- alternative https://github.com/machakann/vim-sandwich
  { 'tpope/vim-surround' },
  { 'windwp/nvim-spectre' },
  { 'dyng/ctrlsf.vim' },
  { 'marko-cerovac/material.nvim' },
  { 'tpope/vim-unimpaired' },

  {
    'numToStr/Comment.nvim',
    config = function()
      local ts_comment_integration = require('ts_context_commentstring.integrations.comment_nvim')
      require('Comment').setup({
        pre_hook = ts_comment_integration.create_pre_hook(),
      })
    end
  },

  -- {
  --   "folke/trouble.nvim",
  --   dependencies = "kyazdani42/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },

  {
    "folke/which-key.nvim",
    lazy = true,
    -- config = function()
    --   require("which-key").setup {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --   }
    -- end
  },

  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local telescope = require('telescope')
      -- telescope.load_extension('fzf')
      telescope.load_extension('refactoring')

      -- local trouble = require("trouble.providers.telescope")

      telescope.setup {
        defaults = {
          sorting_strategy = "ascending",
          mappings = {
            -- restore default behavior
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              -- ["<c-t>"] = trouble.open_with_trouble
            },
            n = {
              -- ["<c-t>"] = trouble.open_with_trouble
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
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  { 'slim-template/vim-slim' },

  {
    "cuducos/yaml.nvim",
    ft = { "yaml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim" -- optional
    },
  },

  --     use 'isobit/vim-caddyfile'
  { 'tpope/vim-rails' },
  --     use 'slim-template/vim-slim'
  { 'dhruvasagar/vim-table-mode' },
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' }
    }
  },


  -- function/class annotation generator
  {
    'danymat/neogen',
    config = function()
      require('neogen').setup()
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
  },


  {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({
        check_ts = true
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },

  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'tree-sitter/tree-sitter-embedded-template' },
  { 'RRethy/nvim-treesitter-endwise' },
  { 'windwp/nvim-ts-autotag' },
  { 'andymass/vim-matchup' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup {
        separator = '-'
      }
    end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = require('plugins.treesitter'),
  }
})

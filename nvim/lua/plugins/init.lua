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
    branch = 'v2.x',
    -- cmd = 'LspInfo',
    -- event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'neovim/nvim-lspconfig',
      },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'nvim-tree/nvim-web-devicons' },
      {
        'ray-x/lsp_signature.nvim',
        opts = {},
      },

      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',

      'folke/neodev.nvim',
      -- { 'j-hui/fidget.nvim',          opts = {} },

      'mfussenegger/nvim-jdtls',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
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

  { 'lvimuser/lsp-inlayhints.nvim', opts = {} },

  -- TODO: add as source https://github.com/zbirenbaum/copilot-cmp
  { 'zbirenbaum/copilot-cmp',       opts = {} },

  { 'tpope/vim-sensible' },

  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'svban/YankAssassin.vim' },

  -- { 'lambdalisue/nerdfont.vim' },

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
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    opts = {},
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' }
    }
  },

  {
    'akinsho/bufferline.nvim',
    opts = {},
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },

  { 'tpope/vim-fugitive' },
  { 'LudoPinelli/comment-box.nvim' },

  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    'ten3roberts/qf.nvim',
    opts = {},
  },

  {
    'neogitorg/neogit',
    opts = {},
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { 'tpope/vim-repeat' },

  {
    'kosayoda/nvim-lightbulb',
    config = function()
      local lightbulb = require('nvim-lightbulb')
      lightbulb.setup({ autocmd = { enabled = true } })
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {},
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = { theme = 'material' },
    -- dependencies = {
    --   'linrongbin16/lsp-progress.nvim',
    -- }
  },

  -- https://github.com/linrongbin16/lsp-progress.nvim
  -- {
  --   'linrongbin16/lsp-progress.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   opts = {}
  -- },

  { -- maybe https://github.com/0x00-ketsu/autosave.nvim
    'nvim-zh/auto-save.nvim',
    opts = {},
  },

  -- { 'ntpeters/vim-better-whitespace' },
  -- -- Using packer.nvim
  {
    'johnfrankmorgan/whitespace.nvim',
    config = function()
      require('whitespace-nvim').setup({
        -- configuration options and their defaults

        -- `highlight` configures which highlight is used to display
        -- trailing whitespace
        highlight = 'DiffDelete',

        -- `ignored_filetypes` configures which filetypes to ignore when
        -- displaying trailing whitespace
        ignored_filetypes = { 'lazy', 'dashboard', 'TelescopePrompt', 'Trouble', 'help' },

        -- `ignore_terminal` configures whether to ignore terminal buffers
        ignore_terminal = true,
      })

      -- remove trailing whitespace with a keybinding
      vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
    end
  },

  { 'tpope/vim-sleuth' },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'UIEnter',
    opts = {
      use_treesitter = true,
      show_current_context = true,
    },
    -- config = function()
    --   require('indent_blankline').setup {
    --     char = '┊',
    --     show_trailing_blankline_indent = false,
    --   }
    -- end
  },

  -- alternative https://github.com/machakann/vim-sandwich
  { 'tpope/vim-surround' },
  { 'windwp/nvim-spectre' },
  { 'dyng/ctrlsf.vim' },
  {
    'marko-cerovac/material.nvim',
    priority = 1000,
    config = function()
      require('material').setup {
        plugins = {
          -- "dap",
          "dashboard",
          "gitsigns",
          -- "hop",
          "indent-blankline",
          -- "lspsaga",
          -- "mini",
          "neogit",
          -- "neorg",
          "nvim-cmp",
          -- "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          -- "sneak",
          "telescope",
          -- "trouble",
          "which-key",
        }
      }
      vim.g.material_style = "deep ocean"
      vim.cmd.colorscheme('material')
    end
  },
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
  --   dependencies = "nvim-tree/nvim-web-devicons",
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
    opts = {},
  },

  {
    "folke/which-key.nvim",
    opts = {},
  },

  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local telescope = require('telescope')

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

  -- function/class annotation generator
  {
    'danymat/neogen',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
  },
  { 'tree-sitter/tree-sitter-embedded-template' },
  { 'RRethy/nvim-treesitter-endwise' },
  { 'windwp/nvim-ts-autotag' },
  {
    'nvim-treesitter/nvim-treesitter-context',
    -- config = function()
    --   require 'treesitter-context'.setup {
    --     separator = '-'
    --   }
    -- end
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = require('plugins.treesitter'),
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },

  { 'andymass/vim-matchup' },
})

local result = require('packer').startup({

function(use)
  use {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup()
      npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
      npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
      npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    end
  }
  -- use 'tpope/vim-sleuth'
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
    'ray-x/lsp_signature.nvim',
    config = function ()
      require "lsp_signature".setup()
    end
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

  use {
	  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function ()
	  require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
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
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

  end
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- use { 'andymass/vim-matchup' }

  use {
    'williamboman/nvim-lsp-installer',
    requires = { { 'neovim/nvim-lspconfig' } },
    config = function()
         local lsp_installer = require "nvim-lsp-installer"

	 local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

         lsp_installer.on_server_ready(function(server)
	local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

            server:setup(opts)
            -- vim.cmd [[ do User LspAttachBuffers ]]
         end)
      end,
  }

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
    requires = { { 'nvim-lua/plenary.nvim' } }
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

  require('plugins.autocomplete')(use)
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}
})

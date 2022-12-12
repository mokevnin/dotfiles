local M = {}

function M.run(use)
  servers = {
    'marksman',
    'tsserver',
    'ansiblels',
    'bashls',
    'dockerls',
    'elixirls',
    'gopls',
    'grammarly',
    'gradle_ls',
    'graphql',
    'groovyls',
    'hls',
    'jdtls',
    'kotlin_language_server',
    'omnisharp',
    'psalm',
    'pyright',
    -- 'sorbet',
    'sqlls',
    'sumneko_lua',
    'stylelint_lsp',
    'terraformls',
    'vimls',
    'yamlls',
    'html',
    'cssls',
    'eslint',
    'jsonls',
    -- 'ruby_ls',
    'solargraph',
    'sumneko_lua',
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

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
    config = function()
      -- vim.lsp.set_log_level('debug')
      local lspconfig = require('lspconfig')

      local solargraph_opts = {
        cmd = { 'bin/solargraph' }
      }

      -- lspconfig.solargraph.setup(solargraph_opts)

      local lsp = require('lsp-zero')
      lsp.preset('recommended')

      lsp.ensure_installed(servers)

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        local bind = vim.keymap.set

        bind("n", "<leader>f", vim.lsp.buf.formatting, opts)
        -- bind('n', "gr", "<cmd>TroubleToggle quickfix<cr>", opts)
        bind('n', '<space>rn', vim.lsp.buf.rename, opts)
        bind('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        -- bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
      end)

      lsp.configure('solargraph', solargraph_opts)

      lsp.setup()

      local null_ls = require('null-ls')
      local null_opts = lsp.build_options('null-ls', {})

      null_ls.setup({
        on_attach = null_opts.on_attach,
        sources = {
          --- do whatever you need to do
        }
      })

      local cmp = require('cmp')
      -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local sources = lsp.defaults.cmp_sources()
      table.insert(sources, { name = 'nvim_lsp_signature_help' })

      -- looks terrible. Waiting for an improvement
      -- local lspkind = require('lspkind')

      local cmp_config = lsp.defaults.cmp_config({
        -- formatting = {
        --   format = lspkind.cmp_format({
        --     mode = 'symbol',
        --     maxwidth = 50,
        --     ellipsis_char = '...',
        --   }),
        -- },
        preselect = 'none',
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        },
        sources = sources,
        -- mapping = {
        --   ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        --   ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- },
      })

      cmp.setup(cmp_config)

    end
  }

  use {
    'j-hui/fidget.nvim',
   kconfig = function()
      require"fidget".setup{}
    end,
  }

  -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  -- use {
  --   'neovim/nvim-lspconfig',
  --   requires = {
  --     'williamboman/mason.nvim',
  --     'williamboman/mason-lspconfig.nvim',
  --     'kosayoda/nvim-lightbulb',
  --   },
  --   config = function()
  --     local opts = { noremap=true, silent=true }
  --     vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  --     vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  --     vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  --     vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  --
  --     -- Use an on_attach function to only map the following keys
  --     -- after the language server attaches to the current buffer
  --     local on_attach = function(client, bufnr)
  --       -- Enable completion triggered by <c-x><c-o>
  --       vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  --
  --       -- Mappings.
  --       -- See `:help vim.lsp.*` for documentation on any of the below functions
  --       local bufopts = { noremap=true, silent=true, buffer=bufnr }
  --       vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  --       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --       vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --       vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --       vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --       vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --       vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --       vim.keymap.set('n', '<space>wl', function()
  --         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --       end, bufopts)
  --       vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  --       vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  --       vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  --       vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --       vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  --     end
  --
  --     -- local lsp_flags = {
  --     --   -- This is the default in Nvim 0.7+
  --     --   debounce_text_changes = 150,
  --     -- }
  --     -- require('lspconfig')['tsserver'].setup{
  --     --   on_attach = on_attach,
  --     --   flags = lsp_flags,
  --     -- }
  --
  --     local lspconfig = require('lspconfig')
  --
  --     -- Enable some language servers with the additional completion capabilities offered by coq_nvim
  --     -- for _, lsp in ipairs(servers) do
  --     --   lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
  --     --     on_attach = on_attach
  --     --   }))
  --     -- end
  --   end
  -- }
end

return M

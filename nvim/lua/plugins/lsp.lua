local servers = {
  'marksman',
  'ltex',
  'tsserver',
  'phpactor',
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
  'lua_ls',
  'stylelint_lsp',
  'terraformls',
  'rubocop',
  -- 'ruby_ls',
  'vimls',
  'yamlls',
  'html',
  -- 'haml-lint',
  'cssls',
  'eslint',
  'jsonls',
  'solargraph',
}

Configure = function()
  -- vim.lsp.set_log_level('debug')
  local lsp = require('lsp-zero')
  lsp.preset({
    manage_nvim_cmp = {
      set_extra_mappings = true
    }
  })

  lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }
    local bind = vim.keymap.set

    bind('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    -- bind('n', "gr", "<cmd>TroubleToggle quickfix<cr>", opts)
    bind('n', '<space>rn', vim.lsp.buf.rename, opts)
    bind('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end)

  lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
  })

  lsp.ensure_installed(servers)

  local lsp_config = require('lspconfig')

  -- local mason_lspconfig = require('mason-lspconfig')
  -- mason_lspconfig.setup({
  --   ensure_installed = servers
  -- })
  lsp_config.lua_ls.setup(lsp.nvim_lua_ls())


  lsp_config.jsonls.setup {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  }

  lsp_config.ltex.setup {
    settings = {
      ltex = {
        language = "ru-RU"
      }
    },
  }

  lsp_config.yamlls.setup {
    settings = {
      yaml = {
        -- schemas = require('schemastore').yaml.schemas(),
        -- schemaStore = {
        --   -- You must disable built-in schemaStore support if you want to use
        --   -- this plugin and its advanced options like `ignore`.
        --   enable = false,
        -- },
      },
    },
  }

  -- setup through nvim-jdtls
  -- https://www.reddit.com/r/neovim/comments/12gaetp/how_to_use_nvimjdtls_for_java_and_nvimlspconfig/
  lsp.skip_server_setup({ 'jdtls' })

  lsp.setup()

  -- https://github.com/windwp/nvim-autopairs#you-need-to-add-mapping-cr-on-nvim-cmp-setupcheck-readmemd-on-nvim-cmp-repo
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )

  local lspkind = require('lspkind')
  cmp.setup({
    sources = {
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'buffer',  keyword_length = 3 },
      { name = 'luasnip', keyword_length = 2 },
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    formatting = {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      fields = { 'abbr', 'kind', 'menu' },
      format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        maxwidth = 50,
        ellipsis_char = '...',
        menu = ({
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          luasnip = '[LuaSnip]',
        })
      })
    }
  })

  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  require('luasnip.loaders.from_vscode').lazy_load()

  local slim_diagnostics = require('plugins.null-ls.slim-lint')

  local null_ls = require('null-ls')
  -- local null_opts = lsp.build_options('null-ls', {})

  require('mason-null-ls').setup({
    ensure_installed = {
      'markuplint',
      'prettier',
      'haml_lint',
      'actionlint',
      'codespell',
      'curlylint',
      'djlint',
      'erb_lint',
      'flake8',
      'hadolint',
      'selene',
      'jsonlint',
      'stylelit',
      'yamllint',
      'puglint',
      'shfmt',
    },
    automatic_installation = true,
    handlers = {},
  })

  null_ls.setup({
    debug = false,
    -- on_attach = null_opts.on_attach,
    sources = {
      slim_diagnostics,
      null_ls.builtins.diagnostics.haml_lint,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.diagnostics.actionlint,
      -- null_ls.builtins.diagnostics.checkmake,
      null_ls.builtins.diagnostics.codespell,
      null_ls.builtins.diagnostics.curlylint,
      null_ls.builtins.diagnostics.djlint,
      null_ls.builtins.diagnostics.dotenv_linter,
      -- null_ls.builtins.diagnostics.editorconfig_checker,
      null_ls.builtins.diagnostics.erb_lint,
      null_ls.builtins.formatting.erb_lint,
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.diagnostics.checkstyle.with({
        null_ls.builtins.diagnostics.golangci_lint,
        extra_args = { '-c', './config/checkstyle/checkstyle.xml' },
      }),
      null_ls.builtins.formatting.shfmt,
      -- null_ls.builtins.diagnostics.selene,
      -- null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.markuplint,
      null_ls.builtins.diagnostics.puglint,
      -- null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.stylelint,
      null_ls.builtins.formatting.stylelint,
      null_ls.builtins.diagnostics.tidy,
      -- null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.zsh,
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.formatting.beautysh,
      null_ls.builtins.formatting.codespell,
      -- null_ls.builtins.formatting.djlint,
      null_ls.builtins.formatting.isort,
      -- null_ls.builtins.formatting.jq,
      -- null_ls.builtins.formatting.lua_format,
      null_ls.builtins.formatting.prettier,
      -- null_ls.builtins.formatting.nginx_beautifier,
      -- null_ls.builtins.formatting.pg_format,
      null_ls.builtins.formatting.phpcbf,
      -- null_ls.builtins.formatting.phpcsfixer,
      -- null_ls.builtins.formatting.terrafmt,
      null_ls.builtins.formatting.terraform_fmt,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.xmllint,
      null_ls.builtins.hover.printenv,
      -- null_ls.builtins.formatting.eslint,
    }
  })
end

return Configure

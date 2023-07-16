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
  -- lsp.preset({})

  lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    local opts = { buffer = bufnr, remap = false }
    local bind = vim.keymap.set

    bind('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    -- bind('n', "gr", "<cmd>TroubleToggle quickfix<cr>", opts)
    bind('n', '<space>rn', vim.lsp.buf.rename, opts)
    bind('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end)

  -- lsp.ensure_installed(servers)

  local lsp_config = require('lspconfig')

  -- https://www.reddit.com/r/neovim/comments/12gaetp/how_to_use_nvimjdtls_for_java_and_nvimlspconfig/
  local mason = require('mason')
  mason.setup({})

  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup({
    ensure_installed = servers
  })

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
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  }

  -- setup through nvim-jdtls
  lsp.skip_server_setup({ 'jdtls' })

  lsp.setup()

  local slim_diagnostics = require('plugins.null-ls.slim-lint')

  local null_ls = require('null-ls')
  local null_opts = lsp.build_options('null-ls', {})

  null_ls.setup({
    debug = true,
    on_attach = null_opts.on_attach,
    sources = {
      slim_diagnostics,
      null_ls.builtins.diagnostics.haml_lint,
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.shellcheck,
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.checkmake,
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
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.puglint,
      -- null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.stylelint,
      null_ls.builtins.formatting.stylelint,
      null_ls.builtins.diagnostics.tidy,
      null_ls.builtins.diagnostics.yamllint,
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

  local cmp = require('cmp')
  local sources = lsp.defaults.cmp_sources()
  table.insert(sources, { name = 'nvim_lsp_signature_help' })

  local cmp_config = lsp.defaults.cmp_config({
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

return Configure

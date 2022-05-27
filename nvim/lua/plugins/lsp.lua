local M = {}

function M.run(use)

  use {
    'williamboman/nvim-lsp-installer',
    { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' },
    'ms-jpq/coq.artifacts',
    'ms-jpq/coq.thirdparty',
    {
      'neovim/nvim-lspconfig',
      config = function ()
        local lsp_installer = require("nvim-lsp-installer")
        lsp_installer.setup({ automatic_installation = true })

        local enhance_server_opts = {
          ["jsonls"] = function(opts)
            opts.settings = {
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
              },
            }
          end,
        }

        -- Diagnostic keymaps
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        -- LSP settings
        local lspconfig = require 'lspconfig'
        local on_attach = function(_, bufnr)
          local opts = { buffer = bufnr }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          end, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
          vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
        end

        vim.g.coq_settings = { auto_start = 'shut-up' }

        local coq = require('coq')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- https://github.com/williamboman/nvim-lsp-installer/discussions/636
        for _, server in ipairs(lsp_installer.get_installed_servers()) do
          local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }

          if enhance_server_opts[server.name] then
            enhance_server_opts[server.name](opts)
          end

          lspconfig[server.name].setup(
            coq.lsp_ensure_capabilities(opts)
          )
        end
      end
    }
  }

  use 'kosayoda/nvim-lightbulb'
end

return M

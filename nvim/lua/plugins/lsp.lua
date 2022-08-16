local M = {}

function M.run(use)

  use {
    'williamboman/nvim-lsp-installer',
    use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' },
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
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

        -- LSP settings
        local lspconfig = require 'lspconfig'
        local on_attach = function(_, bufnr)
          local bufopts = { buffer = bufnr, noremap = true, silent = true }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<leader>wl', function()
            vim.inspect(vim.lsp.buf.list_workspace_folders())
          end, bufopts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
          -- vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
        end

        vim.g.coq_settings = {
          auto_start = 'shut-up',
          keymap = {
            jump_to_mark = nil,
          }
        }

        local coq = require('coq')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- https://github.com/williamboman/nvim-lsp-installer/discussions/636
        for _, server in ipairs(lsp_installer.get_installed_servers()) do
          local serveropts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }

          if enhance_server_opts[server.name] then
            enhance_server_opts[server.name](serveropts)
          end

          lspconfig[server.name].setup(
            coq.lsp_ensure_capabilities(serveropts)
          )
        end
      end
    }
  }

  use 'kosayoda/nvim-lightbulb'
end

return M

local M = {}

function M.run(use)
  servers = {
    'tsserver',
    'eslint',
    'solargraph',
    'sumneko_lua',
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers
      })
    end
  }

  -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  use {
    'ms-jpq/coq_nvim', run = 'python3 -m coq deps',
    config = function()
      -- integration with https://github.com/windwp/nvim-autopairs
      local remap = vim.api.nvim_set_keymap
      local npairs = require('nvim-autopairs')

      npairs.setup({ map_bs = false, map_cr = false })

      vim.g.coq_settings = { keymap = { recommended = false } }

      -- these mappings are coq recommended mappings unrelated to nvim-autopairs
      remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
      remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
      remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
      remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

      -- skip it, if you use another global object
      _G.MUtils= {}

      MUtils.CR = function()
        if vim.fn.pumvisible() ~= 0 then
          if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
            return npairs.esc('<c-y>')
          else
            return npairs.esc('<c-e>') .. npairs.autopairs_cr()
          end
        else
          return npairs.autopairs_cr()
        end
      end
      remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

      MUtils.BS = function()
        if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
          return npairs.esc('<c-e>') .. npairs.autopairs_bs()
        else
          return npairs.autopairs_bs()
        end
      end
      remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
    end
  }
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'kosayoda/nvim-lightbulb',
    },
    config = function()
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
      end

      -- local lsp_flags = {
      --   -- This is the default in Nvim 0.7+
      --   debounce_text_changes = 150,
      -- }
      -- require('lspconfig')['tsserver'].setup{
      --   on_attach = on_attach,
      --   flags = lsp_flags,
      -- }

      local lspconfig = require('lspconfig')

      -- Automatically start coq
      vim.g.coq_settings = {
        auto_start = true,
        keymap = {
          jump_to_mark = '',
        }
      }

      -- Enable some language servers with the additional completion capabilities offered by coq_nvim
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
          on_attach = on_attach
        }))
      end
    end
  }
end

return M

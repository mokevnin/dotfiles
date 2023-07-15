-- https://www.reddit.com/r/neovim/comments/12gaetp/how_to_use_nvimjdtls_for_java_and_nvimlspconfig/

local jdtls_bin = vim.fn.stdpath('data') .. '/mason/bin/jdtls'
-- local lsp = require('lsp-zero')
-- local lsp_attach = function(client, bufnr)
--   lsp.default_keymaps({ buffer = bufnr })
--   -- mappings here
-- end

local config = {
    cmd = { jdtls_bin },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    on_attach = lsp_attach,
}
require('jdtls').start_or_attach(config)

return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = {
        null_ls.builtins.diagnostics.phpstan,
        null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.formatting.phpcsfixer,
        null_ls.builtins.formatting.phpcbf,
        null_ls.builtins.formatting.pint,
        -- nls.builtins.code_actions.gitsigns,
        -- -- go
        -- nls.builtins.code_actions.gomodifytags,
        -- nls.builtins.code_actions.impl,
        -- nls.builtins.diagnostics.golangci_lint,
        -- -- ts
        -- nls.builtins.formatting.biome,
        -- require("typescript.extensions.null-ls.code-actions"),
        -- other
        -- nls.builtins.formatting.stylua,
        -- nls.builtins.formatting.shfmt,
      }
      return opts
    end,
  },
}

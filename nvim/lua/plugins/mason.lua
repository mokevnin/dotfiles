return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "phpstan",
        "phpcs",
        "phpcbf",
        "php-cs-fixer",
        "ruby-lsp",
        "pint",
        "tlint",
        -- table.insert(opts.ensure_installed, "phpstan")
        -- table.insert(opts.ensure_installed, "phpcs")
        -- table.insert(opts.ensure_installed, "phpcbf")
        -- table.insert(opts.ensure_installed, "php-cs-fixer")
      },
    },
  },
}

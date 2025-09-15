return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "phpstan",
        "pint",
        "tlint",
        "haml-lint"
        -- table.insert(opts.ensure_installed, "phpstan")
        -- table.insert(opts.ensure_installed, "phpcs")
        -- table.insert(opts.ensure_installed, "phpcbf")
        -- table.insert(opts.ensure_installed, "php-cs-fixer")
      },
    },
  },
}

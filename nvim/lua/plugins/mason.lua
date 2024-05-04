return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "phpstan")
      table.insert(opts.ensure_installed, "phpcs")
      table.insert(opts.ensure_installed, "phpcbf")
      table.insert(opts.ensure_installed, "php-cs-fixer")
    end,
  },
}

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "kotlin-language-server")
      table.insert(opts.ensure_installed, "lemminx")
      table.insert(opts.ensure_installed, "google-java-format")
    end,
  },
}

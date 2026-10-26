return {
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "stevearc/oil.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      require("kotlin").setup({
        jvm_args = { "-Xmx4g" },
        inlay_hints = {
          enabled = true,
        },
      })
    end,
  },
}

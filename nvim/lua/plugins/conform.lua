return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- log_level: vim.log.levels.DEBUG,
      formatters_by_ft = {
        php = {
          "pint",
          "tlint",
        },
        java = { "spotless_gradle" },
        -- haml = { "haml_lint" },
      },
      formatters = {
        -- spotless = {
        --   command = "./gradlew",
        --   args = { "spotlessApply" },
        --   cwd = require("conform.util").root_file({ "build.gradle.kts" }),
        --   stdin = false,
        -- },
        -- haml_lint = {
        --   -- command = "haml-lint",
        --   -- args = function(self, ctx)
        --   --   return { "--auto-correct", ctx.filename }
        --   -- end,
        --   -- stdin = false,
        --   -- condition = function(ctx)
        --   --   return vim.fn.executable("haml-lint") == 1
        --   -- end,
        --   -- cwd = require("conform.util").root_file({ ".haml-lint.yml", ".git" }),
        --   command = "haml-lint",
        --   args = function(_, ctx)
        --     return { "--auto-correct", ctx.filename } -- или "--auto-correct-all" для агрессивного режима
        --   end,
        --   stdin = false,
        --   tmpfile_format = ".conform.$RANDOM.$FILENAME", -- используем temp-файл для записи и чтения
        --   condition = function()
        --     return vim.fn.executable("haml-lint") == 1
        --   end,
        --   cwd = require("conform.util").root_file({ ".haml-lint.yml", ".git" }),
        --   exit_codes = { 0, 1 }, -- 1 = предупреждения
        -- },
      },
    },
  },
}

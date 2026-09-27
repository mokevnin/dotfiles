return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- conform only rewrites the file, so the diagnostics come from here;
        -- mago comes from mise.toml, it is not in the mason registry
        php = { "mago_lint", "mago_analyze" },
        -- workflows get no filetype of their own, the condition below narrows it
        yaml = { "actionlint" },
      },
      linters = {
        actionlint = {
          condition = function(ctx)
            return ctx.filename:find("/%.github/workflows/") ~= nil
          end,
        },
      },
    },
  },
}

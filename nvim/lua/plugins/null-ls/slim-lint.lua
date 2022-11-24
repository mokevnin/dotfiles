local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local slimlint = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "slim" },
  -- null_ls.generator creates an async source
  -- that spawns the command with the given arguments and options
  generator = null_ls.generator({
    command = "slim-lint",
    args = { "$FILENAME" },
    to_stdin = false,
    from_stderr = true,
    -- choose an output format (raw, json, or line)
    format = "line",
    check_exit_code = function(code)
      local success = code <= 1

      -- if not success then
        -- can be noisy for things that run often (e.g. diagnostics), but can
        -- be useful for things that run on demand (e.g. formatting)
      --   print(stderr)
      -- end

      return success
    end,
    -- use helpers to parse the output from string matchers,
    -- or parse it manually with a function
    on_output = helpers.diagnostics.from_patterns({
      {
        pattern = [[:(%d+) (.*)]],
        groups = { "row", "message" },
      }
    }),
  }),
}

null_ls.register(slimlint)

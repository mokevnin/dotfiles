return {
  "folke/snacks.nvim",
  keys = {
    {
      "<space>fj",
      function()
        Snacks.explorer.reveal()
      end,
    },
  },
  opts = {
    picker = {
      win = {
        input = {
          -- keys = {
          --   ["i"] = {
          --     "confirm",
          --     mode = { "n", "i" },
          --   },
          -- },
        },
      },
      sources = {
        explorer = {
          follow_file = false,
          -- follow_file = false,
        },
      },
    },
    -- picker = {
    --   win = {
    --     ["<c-u>"] = { "unix_line_discard", mode = { "i", "n" } },
    --   },
    -- },
  },
}

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<space>fj",
      function()
        Snacks.explorer.reveal()
      end,
    },
    {
      "<leader>fa",
      function()
        Snacks.picker.pick("alternate_files")
      end,
      desc = "Alternate Files",
    },
  },
  opts = function(_, opts)
    local alternate_picker = require("config.alternate_picker")

    opts = opts or {}
    opts.picker = vim.tbl_deep_extend("force", {
      win = {
        input = {
          keys = {
            ["/"] = false,
            --   ["i"] = {
            --     "confirm",
            --     mode = { "n", "i" },
            --   },
          },
        },
        list = {
          keys = {
            ["/"] = false,
          },
        },
      },
      layout = {
        -- hidden = { "input" },
      },
      sources = {
        explorer = {
          -- finder = "files",
          follow_file = false,
          -- supports_live = false,
          -- follow_file = false,
        },
      },
    }, opts.picker or {})

    opts.picker.sources = opts.picker.sources or {}

    opts.picker.sources.files = vim.tbl_deep_extend("force", {
      exclude = { "*.rbi" },
    }, opts.picker.sources.files or {})

    -- opts.picker.sources.explorer = vim.tbl_deep_extend("force", {
    --   exclude = { "*.rbi" },
    -- }, opts.picker.sources.explorer or {})

    opts.picker.sources["alternate_files"] = opts.picker.sources["alternate_files"]
      or {
        title = "Alternate Files",
        prompt = "Alt ",
        finder = alternate_picker.finder,
        format = "file",
        preview = "file",
        confirm = "jump",
        show_empty = true,
      }

    return opts
  end,
}

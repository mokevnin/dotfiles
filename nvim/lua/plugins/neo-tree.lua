return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- window = {
      --   mappings = {
      --     ["o"] = "open",
      --   },
      -- },
      filesystem = {
        follow_current_file = { enabled = false },
        bind_to_cwd = true,
        window = {
          mappings = {
            ["/"] = "none",
          },
        },
        -- follow_current_file = { enabled = true },
      },
    },
  },
}

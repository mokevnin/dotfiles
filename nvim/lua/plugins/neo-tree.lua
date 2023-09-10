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

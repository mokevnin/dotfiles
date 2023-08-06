return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["o"] = "toggle_node",
        },
      },
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

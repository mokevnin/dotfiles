local M = {
  options = {
    nvChad = {
      insert_nav = false
    },
  },
  -- FIXME: make always shown for the tree
  -- https://github.com/NvChad/NvChad/blob/16d035c031c5c4420925551cfa67bb4f39fe1947/lua/core/utils.lua#L121
  mappings = {
    plugins = {
      telescope = {
        buffers = "<leader>b",
      },
      bufferline = {
        next_buffer = "[b",
        prev_buffer = "]b",
      },
      nvimtree = {
        toggle = "<leader><leader>",
      },
    }
  }
}

return M

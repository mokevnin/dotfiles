local M = {
  options = { },
  mappings = {
    plugins = { }
  }
}

M.options = {
  nvChad = {
    insert_nav = false
  },
}

M.mappings.plugins = {
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

return M

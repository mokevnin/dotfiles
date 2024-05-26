return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.endwise = {
        enable = true,
      }
      opts.swap = {
        enable = true,
      }

      opts.autotag = {
        enable = true,
      }

      opts.select = {
        enable = true,
      }
      opts.textobjects = {
        lsp_interop = {
          enable = true,
        },
      }
    end,
  },
}

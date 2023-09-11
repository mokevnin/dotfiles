return {
  { "isobit/vim-caddyfile" },
  { -- maybe https://github.com/0x00-ketsu/autosave.nvim
    "0x00-ketsu/autosave.nvim",
    opts = {},
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  { "slim-template/vim-slim" },
  { "tpope/vim-rails" },
  --     use 'slim-template/vim-slim'
  { "dhruvasagar/vim-table-mode" },
  { "tree-sitter/tree-sitter-embedded-template" },
  { "RRethy/nvim-treesitter-endwise" },
  { "windwp/nvim-ts-autotag" },
  { "dyng/ctrlsf.vim" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {},
  },
}

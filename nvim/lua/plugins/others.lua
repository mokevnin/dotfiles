return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        enabled = false,
        -- sign = true,
      }
    },
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "openai",
          },
          inline = {
            adapter = "openai",
          },
          cmd = {
            adapter = "openai",
          },
        },
        -- extensions = {
        --   mcphub = {
        --     callback = "mcphub.extensions.codecompanion",
        --     opts = {
        --       make_vars = true,
        --       make_slash_commands = true,
        --       show_result_in_chat = true,
        --     },
        --   },
        -- },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { command = false },
    },
  },
  -- {
  --   "adalessa/laravel.nvim",
  --   ft = { "php" },
  --   opts = {},
  -- },
  -- {
  --   "towolf/vim-helm",
  -- },
  -- {
  --   "tigion/nvim-asciidoc-preview",
  --   ft = { "asciidoc" },
  --   opts = {},
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {},
  -- },
  { "isobit/vim-caddyfile" },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },
  -- {
  --   "s1n7ax/nvim-window-picker",
  --   name = "window-picker",
  --   event = "VeryLazy",
  --   version = "2.*",
  --   config = function()
  --     require("window-picker").setup()
  --   end,
  -- },
  -- { "tpope/vim-rails" },
  -- { "slim-template/vim-slim" },
  { "dhruvasagar/vim-table-mode" },
  -- { "tree-sitter/tree-sitter-embedded-template" },
  { "RRethy/nvim-treesitter-endwise" },
  -- { "dyng/ctrlsf.vim" },
  -- { "digitaltoad/vim-pug" },
  -- {
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
}

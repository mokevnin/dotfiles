return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- sorting_strategy = "ascending",
        mappings = {
          -- restore default behavior
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
          n = {},
        },
      },
      -- pickers = {
      --   buffers = {
      --     ignore_current_buffer = true,
      --     sort_mru = true,
      --   },
      -- },
    },
  },
  {
    "otavioschwanck/telescope-alternate",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true,
    opts = {
      mappings = {
        {
          "app/Http/Controllers/(.*)Controller.php",
          {
            { "tests/Feature/[1]Test.php", "Test" },
            { "resources/js/Pages/[1]/*.tsx", "View" },
          },
        },
        {
          "app/Models/(.*).php",
          {
            { "tests/Unit/[1]Test.php", "Test" },
            { "database/factories/[1]Factory.php", "Factory" },
          },
        },
        {
          "database/factories/(.*)Factory.php",
          {
            -- { "tests/Models/[1]Test.php", "Test" },
            { "app/Models/[1].php", "Model" },
          },
        },
        {
          "tests/Feature/(.*)Test.php",
          {
            { "app/Http/Controllers/[1]Controller.php", "Controller" },
          },
        },
        {
          "tests/Unit/(.*)Test.php",
          {
            { "app/Models/[1].php", "Model" },
          },
        },
        {
          "resources/js/Pages/(.*)/.*.tsx",
          {
            { "app/Http/Controllers/[1]Controller.php", "Controller" },
          },
        },
      },
    },
  },

}

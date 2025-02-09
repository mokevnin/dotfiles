return {
  {
    "rgroli/other.nvim",
    event = "VeryLazy",
    config = function()
      require("other-nvim").setup({
        showMissingFiles = true,
        mappings = {
          "react",
          "rails",
          {
            pattern = "/app/controllers/(.*)_controller.rb",
            target = {
              { context = "react", target = "/app/javascript/pages/%1/*.tsx" },
            },
          },
          {
            pattern = "/app/javascript/pages/(.*)/.*.tsx",
            target = {
              { context = "controller", target = "/app/controllers/%1_controller.rb" },
            },
          },
        },
      })
    end,
  },
}

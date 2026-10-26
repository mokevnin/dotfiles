-- `langmap` работает только на уровне нажатий клавиш и принципиально не
-- покрывает маппинги -- ни `<leader>`-последовательности, ни то, что вешают
-- плагины. Langmapper оборачивает `vim.keymap.set`, поэтому переводит вообще
-- все маппинги: LazyVim, which-key, snacks, trouble и остальное.
--
-- Грузиться должен раньше всех плагинов, которые ставят маппинги: LazyVim идёт
-- с priority = 10000, snacks -- с 1000, отсюда 9999.
return {
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 9999,
    config = function()
      local layout = require("config.layout")

      require("langmapper").setup({
        hack_keymap = true,
        map_all_ctrl = true,
        default_layout = layout.default_layout,
        layouts = {
          ru = {
            id = "com.apple.keylayout.RussianWin",
            layout = layout.layout,
          },
        },
      })

      -- hack_keymap перехватывает только те маппинги, что ставят после
      -- загрузки langmapper. Заглушки для `keys` отложенных плагинов lazy
      -- регистрирует раньше, ещё в Lazy.setup(), поэтому по-русски они не
      -- ловятся (<leader>j у treesj, <leader>D у dadbod-ui и т.п.).
      -- automapping добирает их, пройдясь по уже зарегистрированным маппингам.
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          -- buffer = false: nvim_buf_set_keymap и так перехвачен
          vim.schedule(function()
            require("langmapper").automapping({ global = true, buffer = false })
          end)
        end,
      })
    end,
  },
}

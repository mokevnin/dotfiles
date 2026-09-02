return {
  -- disable trouble
  -- { "folke/flash.nvim", enabled = false },
  -- {
  { "folke/noice.nvim", enabled = false },
  -- { "folke/mini.ai", enabled = false },
  { "folke/flash.nvim", enabled = false },

  -- Ниже -- плагины, у которых upstream давно не двигается, а живой замены нет.
  -- Выключены осознанно: лучше не тащить незакрытый код, чем ждать починки.
  -- Дата -- последний коммит upstream на момент выключения.

  -- 2025-05-25. Значения переменных инлайном во время dap-сессии.
  { "theHamsta/nvim-dap-virtual-text", enabled = false },

  -- 2025-07-11. Вместе с ним уходит вся отладка go: dap.configurations.go
  -- заводил только он (см. dap_go_enabled в plugins/neotest.lua).
  { "leoluz/nvim-dap-go", enabled = false },

  -- 2025-03-19. Автодополнение таблиц и колонок в SQL-буферах dadbod.
  -- Сам vim-dadbod и dadbod-ui живы и остаются; источник `dadbod`
  -- выпиливается из blink в plugins/blink.lua.
  { "kristijanhusak/vim-dadbod-completion", enabled = false },
}

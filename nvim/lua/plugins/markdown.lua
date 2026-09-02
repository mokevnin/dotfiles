-- markdown-preview.nvim из lazyvim.plugins.extras.lang.markdown заброшен:
-- последний коммит upstream -- октябрь 2023, репозиторий в архиве. Вместо него
-- live-preview.nvim: бэкенд целиком на lua, без node-сборки на `build`,
-- умеет markdown/asciidoc/html/svg + katex и mermaid.
local LIVE_FT = { "markdown", "html", "asciidoc", "svg" }

return {
  { "iamcco/markdown-preview.nvim", enabled = false },

  {
    "brianhuster/live-preview.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = "LivePreview",
    -- ft на самих keys, а не на плагине: иначе он грузился бы на каждом
    -- markdown-буфере, а <leader>cp занимал бы клавишу и в ruby, и в go
    keys = {
      { "<leader>cp", "<cmd>LivePreview start<cr>", ft = LIVE_FT, desc = "Live Preview (start)" },
      { "<leader>cP", "<cmd>LivePreview close<cr>", ft = LIVE_FT, desc = "Live Preview (close)" },
    },
    -- у плагина нет setup(), конфиг ставится отдельной функцией
    config = function()
      require("livepreview.config").set({
        picker = "snacks.picker",
      })
    end,
  },
}

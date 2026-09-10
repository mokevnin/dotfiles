-- markdown-preview.nvim из lazyvim.plugins.extras.lang.markdown заброшен:
-- последний коммит upstream -- октябрь 2023, репозиторий в архиве. Вместо него
-- live-preview.nvim: бэкенд целиком на lua, без node-сборки на `build`,
-- умеет markdown/asciidoc/html/svg + katex и mermaid.
local LIVE_FT = { "markdown", "html", "asciidoc", "svg" }

return {
  { "iamcco/markdown-preview.nvim", enabled = false },

  {
    -- свой форк: в upstream вшит mermaid 11.3.0 -- его забыли добавить в
    -- еженедельное обновление зависимостей, чинится в
    -- brianhuster/live-preview.nvim#378, но и тот PR пинит мажор на 11.
    -- В ветке -- mermaid 12: там look "neo" и темы redux-color/
    -- redux-dark-color стали дефолтом, ими и рисуем, так что картинка та
    -- же, что у upstream по умолчанию. Наверх не отправляем -- форк нужен,
    -- пока #378 не вмёржен, а мажор в нём не поднят
    "mokevnin/live-preview.nvim",
    branch = "mermaid-neo",
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
      -- дефолтный порт 5500 один на все инстансы nvim, а ошибку bind плагин
      -- глотает молча: вторая сессия уходит в браузер на сервер первой и
      -- получает 404. Поэтому просим у ядра свободный порт на каждый инстанс
      local port = 5500
      local probe = vim.uv.new_tcp()
      if probe then
        if probe:bind("127.0.0.1", 0) then
          port = probe:getsockname().port
        end
        probe:close()
      end

      require("livepreview.config").set({
        picker = "snacks.picker",
        port = port,
      })
    end,
  },
}

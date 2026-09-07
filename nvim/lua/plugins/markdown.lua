-- markdown-preview.nvim из lazyvim.plugins.extras.lang.markdown заброшен:
-- последний коммит upstream -- октябрь 2023, репозиторий в архиве. Вместо него
-- live-preview.nvim: бэкенд целиком на lua, без node-сборки на `build`,
-- умеет markdown/asciidoc/html/svg + katex и mermaid.
local LIVE_FT = { "markdown", "html", "asciidoc", "svg" }

-- В плагин вшит mermaid 11.3.0 (осень 2024), а нам нужен `look: "neo"` --
-- он вместе с темами neo/neo-dark появился заметно позже. Поэтому берём
-- свежий mermaid модулем с cdn.jsdelivr.net: он же и грузит свои чанки по
-- относительным путям, никакой сборки в dotfiles не требуется.
-- Без сети mermaid-блоки останутся обычными code-блоками, остальной документ
-- отрендерится как всегда.
local MERMAID_NEO = [==[
<script type="module">
import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11.17.2/dist/mermaid.esm.min.mjs";

const dark = window.matchMedia("(prefers-color-scheme: dark)");

mermaid.initialize({
	startOnLoad: false,
	securityLevel: "loose",
	look: "neo",
	theme: dark.matches ? "neo-dark" : "neo",
});

// ws-client.js зовёт эту глобальную функцию после каждой перерисовки документа
window.livepreview_renderMermaid = () => {
	mermaid.run({ querySelector: ".language-mermaid" });
};

// после рендера исходник диаграммы затёрт готовым svg, поэтому на смену темы
// проще перезагрузить страницу целиком
dark.addEventListener("change", () => window.location.reload());

window.livepreview_renderMermaid();
</script>
]==]

-- mermaid зашит в шаблон плагина двумя тегами: библиотека в <head> и запуск в
-- конце body. Выкидываем оба, а свой модуль ставим на место второго -- он
-- должен выполниться после разметки и после штатного main.js, иначе тот
-- перетрёт глобальную функцию своей.
local function use_mermaid_neo(html)
  local lib_tag = [[<script src="/live-preview.nvim/static/mermaid/mermaid.min.js"></script>]]
  local init_tag = [[<script defer src="/live-preview.nvim/static/mermaid/main.js"></script>]]

  local dropped, swapped
  html, dropped = html:gsub(vim.pesc(lib_tag), "")
  html, swapped = html:gsub(vim.pesc(init_tag), function()
    return MERMAID_NEO
  end)

  if dropped == 0 or swapped == 0 then
    vim.notify("live-preview: mermaid в шаблоне не найден, свежий не подключён", vim.log.levels.WARN)
  end

  return html
end

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

      -- toHTML в handler.lua захвачен локальной переменной, но внутри зовёт
      -- M.md2html/M.adoc2html через таблицу модуля -- их и оборачиваем
      local template = require("livepreview.template")
      for _, name in ipairs({ "md2html", "adoc2html" }) do
        local original = template[name]
        template[name] = function(text)
          return use_mermaid_neo(original(text))
        end
      end
    end,
  },
}

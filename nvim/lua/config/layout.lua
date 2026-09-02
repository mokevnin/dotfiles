-- Единственный источник правды про русскую раскладку (macOS "Russian – PC").
-- Отсюда берут данные и `langmap` (config/options.lua), и langmapper
-- (plugins/langmapper.lua) -- иначе таблицы неизбежно разъезжаются.
--
-- Порядок символов совпадает с дефолтным `default_layout` langmapper'а,
-- поэтому `layout` можно склеить из тех же строк.

local M = {}

M.en_upper = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~]]
M.ru_upper = [[ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪЁ]]
M.en_lower = [[abcdefghijklmnopqrstuvwxyz,.;'[]`]]
M.ru_lower = [[фисвуапршолдьтщзйкыегмцчнябюжэхъё]]

M.default_layout = M.en_upper .. M.en_lower
M.layout = M.ru_upper .. M.ru_lower

-- В `langmap` эти символы обязаны быть экранированы, иначе он ломается
local function escape(str)
  return vim.fn.escape(str, [[;,."|\]])
end

-- `langmap` покрывает только сами нажатия клавиш (движения, операторы).
-- Маппинги (в том числе `<leader>`) он не трогает -- это работа langmapper'а.
function M.langmap()
  return table.concat({
    escape(M.ru_upper) .. ";" .. escape(M.en_upper),
    escape(M.ru_lower) .. ";" .. escape(M.en_lower),
  }, ",")
end

return M

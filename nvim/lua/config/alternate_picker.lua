local uv = vim.uv or vim.loop
local M = {}

local function load_mappings()
  local ok, config = pcall(require, "config.alternate")
  if not ok then
    return {}
  end
  return config.mappings or config
end

local function expand_targets(entry)
  if type(entry.targets) == "table" then
    return entry.targets
  end
  if type(entry.target) == "string" then
    return { entry.target }
  end
  return {}
end

local function normalize_root(path)
  if not path or path == "" then
    return nil
  end
  return vim.fs.normalize(path)
end

local function normalize_target(target, root)
  if not target or target == "" then
    return nil
  end

  if target:sub(1, 1) == "~" then
    target = vim.fn.expand(target)
  end

  if target:sub(1, 1) == "/" then
    if root and not target:find("^" .. vim.pesc(root)) and not uv.fs_stat(target) then
      target = vim.fs.joinpath(root, target:sub(2))
    end
  elseif root then
    target = vim.fs.joinpath(root, target)
  end

  return vim.fs.normalize(target)
end

local function substitute_captures(target, captures)
  local expanded = target
  for i, capture in ipairs(captures) do
    expanded = expanded:gsub("%%" .. i, capture)
  end
  return expanded
end

local function expand_glob(path)
  local matches = vim.fn.glob(path, true, true)
  if type(matches) == "table" then
    return matches
  end
  if type(matches) == "string" and matches ~= "" then
    return vim.split(matches, "\n", { trimempty = true })
  end
  return {}
end

local function has_magic(path)
  return path:find("[%*%[%]?]") ~= nil
end

local function relpath(path, root)
  if not root then
    return path
  end
  local ok, rel = pcall(vim.fs.relpath, path, root)
  return ok and rel or path
end

---@param file string
---@param root? string
---@return snacks.picker.finder.Item[]
function M.items(file, root)
  local normalized_file = vim.fs.normalize(file)
  local normalized_root = normalize_root(root)
  local seen = {}
  local items = {}

  for _, entry in ipairs(load_mappings()) do
    local captures = { normalized_file:match(entry.pattern) }
    if #captures > 0 then
      for _, target in ipairs(expand_targets(entry)) do
        local substituted = substitute_captures(target, captures)
        local absolute_target = normalize_target(substituted, normalized_root)
        if absolute_target then
          local paths = expand_glob(absolute_target)
          -- If glob didn't match anything, skip magic targets, but keep non-glob paths (for creating files).
          if #paths == 0 and not has_magic(substituted) then
            paths = { absolute_target }
          end
          for _, path in ipairs(paths) do
            local normalized = vim.fs.normalize(path)
            local stat = uv.fs_stat(normalized)
            if stat and stat.type == "file" and not seen[normalized] then
              seen[normalized] = true
              items[#items + 1] = {
                file = normalized,
                text = relpath(normalized, normalized_root),
              }
            end
          end
        end
      end
    end
  end

  return items
end

---@type snacks.picker.finder
function M.finder(_, ctx)
  local file = vim.api.nvim_buf_get_name(0)
  local root = require("snacks").git.get_root(file) or ctx:cwd()
  return M.items(file, root)
end

return M

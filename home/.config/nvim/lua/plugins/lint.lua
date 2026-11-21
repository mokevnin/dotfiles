-- A project with .custom-gcl.yml builds its own golangci-lint (`golangci-lint custom`) because
-- .golangci.yml loads module plugins the stock binary does not have ("plugin not found").
-- Returns the configured binary path, or nil when the buffer is not in such a project.
local function custom_gcl(dirname)
  local config = vim.fs.find({ ".custom-gcl.yml", ".custom-gcl.yaml" }, { path = dirname, upward = true })[1]
  if not config then
    return nil
  end
  local name, destination = "custom-gcl", "."
  for _, line in ipairs(vim.fn.readfile(config)) do
    name = line:match("^name:%s*['\"]?([^'\"%s#]+)") or name
    destination = line:match("^destination:%s*['\"]?([^'\"%s#]+)") or destination
  end
  return vim.fs.normalize(vim.fs.joinpath(vim.fs.dirname(config), destination, name))
end

-- GOROOT and GOMODCACHE, asked once: a file there (the stdlib or a dependency, opened by gd) is
-- not the project's, and linting it from the project's cwd picks up the project's .golangci.yml.
local go_dirs
local function outside_project(filename)
  if not go_dirs then
    go_dirs = {}
    local out = vim.fn.systemlist({ "go", "env", "GOROOT", "GOMODCACHE" })
    if vim.v.shell_error == 0 then
      for _, dir in ipairs(out) do
        if dir ~= "" then
          table.insert(go_dirs, vim.fs.normalize(dir) .. "/")
        end
      end
    end
  end
  local file = vim.fs.normalize(filename)
  for _, dir in ipairs(go_dirs) do
    if vim.startswith(file, dir) then
      return true
    end
  end
  return false
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- golangci-lint takes a lock and exits with code 3 ("parallel golangci-lint is running") when
      -- another run holds it: an earlier lint of a buffer, or `mise run check` beside the editor.
      -- Wait for it instead. The flag belongs to `run`, so it goes right after it.
      local gcl_args = vim.deepcopy(require("lint.linters.golangcilint").args or {})
      table.insert(gcl_args, (vim.tbl_contains(gcl_args, "run") and 2 or 1), "--allow-serial-runners")

      return vim.tbl_deep_extend("force", opts, {
        linters_by_ft = {
          -- conform only rewrites the file, so the diagnostics come from here;
          -- mago comes from mise.toml, it is not in the mason registry
          php = { "mago_lint", "mago_analyze" },
          -- workflows get no filetype of their own, the condition below narrows it
          yaml = { "actionlint" },
        },
        linters = {
          actionlint = {
            condition = function(ctx)
              return ctx.filename:find("/%.github/workflows/") ~= nil
            end,
          },
          golangcilint = {
            cmd = function()
              return custom_gcl(vim.fn.expand("%:p:h")) or "golangci-lint"
            end,
            args = gcl_args,
            condition = function(ctx)
              if outside_project(ctx.filename) then
                return false
              end
              -- until the project's binary is built the stock one only fails, so stay quiet
              local bin = custom_gcl(ctx.dirname)
              return bin == nil or vim.fn.executable(bin) == 1
            end,
          },
        },
      })
    end,
  },
}

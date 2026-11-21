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

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
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
          -- until the project's binary is built the stock one only fails, so stay quiet;
          -- a file outside the cwd (the stdlib or a module opened by gd) is not the project's
          condition = function(ctx)
            if not vim.startswith(ctx.filename, vim.fn.getcwd() .. "/") then
              return false
            end
            local bin = custom_gcl(ctx.dirname)
            return bin == nil or vim.fn.executable(bin) == 1
          end,
        },
      },
    },
  },
}

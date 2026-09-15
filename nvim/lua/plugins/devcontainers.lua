return {
  {
    -- `:DevcontainersUp` starts the container described by .devcontainer/ in the
    -- project, `:DevcontainersExec cmd...` runs something inside it. The daemon
    -- is docker-desktop and the `devcontainer` binary it drives is
    -- devcontainer-cli, both declared in mise.toml.
    "jedrzejboczar/devcontainers.nvim",
    -- Running a language server inside the container is opt-in per server --
    -- lsp_cmd wraps the command and falls back to the host when a project has no
    -- .devcontainer/, e.g.
    --   vim.lsp.config("gopls", { cmd = require("devcontainers").lsp_cmd({ "gopls" }) })
    -- Nothing is wrapped yet, so every LSP still starts on the host.
    opts = {},
  },
}

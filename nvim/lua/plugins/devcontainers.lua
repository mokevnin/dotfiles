return {
  {
    -- `:DevcontainersUp` starts the container described by .devcontainer/ in the
    -- project, `:DevcontainersExec cmd...` runs something inside it, and every
    -- language server of such a project is started inside it too. The daemon is
    -- docker-desktop and the `devcontainer` binary it drives is devcontainer-cli,
    -- both declared in mise.toml.
    --
    -- A fork, for jedrzejboczar/devcontainers.nvim#8, which is what lsp_auto below
    -- comes from. Upstream only wraps servers one `cmd` at a time, which does not
    -- reach the ones mason installs and, more to the point, cannot start a server
    -- that exists only inside the container: Neovim drops a config whose command is
    -- not executable on the host before the plugin ever sees it. Back to upstream
    -- once that is merged.
    url = "https://github.com/mokevnin/devcontainers.nvim.git",
    branch = "lsp-auto",
    -- Servers keep running on the host in projects without .devcontainer/, and a
    -- server the container does not have stays on the host as well.
    opts = { lsp_auto = true },
  },
}

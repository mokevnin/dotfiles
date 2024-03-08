return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = false,
        float = {
          border = "rounded",
        },
      },
      servers = {
        kotlin_language_server = {},
        html = {
          filetypes = { 'html', 'blade' }
        },
        bashls = {},
        lemminx = {},
        phpactor = {
          filetypes = { 'php', 'blade' }
        },
        ltex = {
          settings = {
            ltex = {
              language = "ru-RU",
            },
          },
        },
      },
    },
  },
}

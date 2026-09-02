return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- inlay_hints = {
      --   enabled = true,
      -- },
      -- codelens = {
      --   enabled = false,
      -- },
      diagnostics = {
        --   -- underline = true,
        -- virtual_text = false,
        -- virtual_lines = { current_line = true },
        virtual_text = false,
        --   -- float = {
        --   --   border = "rounded",
        --   -- },
      },
      servers = {
        tsp_server = {},
        -- default root markers are Gemfile/.git, which starts srb in every ruby
        -- project next to ruby_lsp and rubocop -- only start it where sorbet lives
        sorbet = {
          root_markers = { "sorbet" },
          workspace_required = true,
        },
        -- cssls = {},
        autotools_ls = {},
        docker_compose_language_service = {},
        -- oxlint = {},
        -- somesass_ls = {},
        ruby_lsp = {
          mason = false,
          cmd = { "/opt/homebrew/bin/mise", "x", "--", "bundle", "exec", "ruby-lsp" },
          init_options = {
            addonSettings = {
              ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
              },
            },
          },
        },
        -- vtsls тут больше нет: extra lang.typescript.tsgo переключает ts_lsp
        -- на отдельный сервер tsgo и сам гасит vtsls, так что его настройки
        -- (включая ручной experimental.useTsgo) были бы мёртвым кодом
        -- cssls = {},
        -- https://github.com/Shopify/ruby-lsp/issues/2347
        -- ruby_lsp = {
        --   mason = false,
        --   cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
        -- },
        -- kotlin_language_server = {},
        -- https://www.arthurkoziel.com/json-schemas-in-neovim/
        -- helm_ls = {},
        -- https://github.com/typescript-language-server/typescript-language-server/pull/218
        -- https://github.com/microsoft/TypeScript/issues/13270
        -- tsserver = {
        --   settings = {
        --     javascript = {
        --       inlayHints = {
        --         parameterNames = { enabled = "literals" },
        --         parameterTypes = { enabled = true },
        --         variableTypes = { enabled = true },
        --         propertyDeclarationTypes = { enabled = true },
        --         functionLikeReturnTypes = { enabled = true },
        --         enumMemberValues = { enabled = true },
        --       },
        --       typescript = {
        --         -- format = {
        --         --   indentSize = vim.o.shiftwidth,
        --         --   convertTabsToSpaces = vim.o.expandtab,
        --         --   tabSize = vim.o.tabstop,
        --         -- },
        --         updateImportsOnFileMove = {
        --           enabled = "always",
        --         },
        --         inlayHints = {
        --           parameterNames = { enabled = "literals" },
        --           parameterTypes = { enabled = true },
        --           variableTypes = { enabled = true },
        --           propertyDeclarationTypes = { enabled = true },
        --           functionLikeReturnTypes = { enabled = true },
        --           enumMemberValues = { enabled = true },
        --         },
        --         -- enables project wide error reporting similar to vscode
        --         -- tsserver = {
        --         --   experimental = {
        --         --     enableProjectDiagnostics = true,
        --         --   },
        --         -- },
        --       },
        --     },
        --     tsserver = {
        --       init_options = {
        --         preferences = {
        --           quoteStyle = "single",
        --         },
        --       },
        --     },
        --   },
        -- },
        -- html = {
        --   -- filetypes = { "html", "blade" },
        -- },
        -- bashls = {},
        -- lemminx = {},
        -- maintained fork of the abandoned ltex-ls; its languagetool 6.8 no longer
        -- trips the JAXP entity limit that JDK 24+ tightened, so no JVM workaround
        ltex_plus = {
          -- only silences the cosmetic native-access warning from bundled jansi
          cmd_env = {
            JAVA_OPTS = "--enable-native-access=ALL-UNNAMED",
          },
          settings = {
            ltex = {
              language = "ru-RU",
              -- default is "fine", which spams every checked fragment into lsp.log
              ["ltex-ls"] = {
                logLevel = "severe",
              },
            },
          },
        },
      },
    },
  },
}

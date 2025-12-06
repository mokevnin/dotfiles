return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
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
        sorbet = {},
        -- cssls = {},
        autotools_ls = {},
        docker_compose_language_service = {},
        -- oxlint = {},
        -- somesass_ls = {},
        ruby_lsp = {
          init_options = {
            addonSettings = {
              ["Ruby LSP Rails"] = {
                enablePendingMigrationsPrompt = false,
              },
            },
          },
        },
        tsgo = {
          keys = {
            {
              "<leader>ca",
              vim.lsp.buf.code_action,
              desc = "Code Action (tsgo)",
              mode = { "n", "x" },
            },
            { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
            { "<leader>cM", LazyVim.lsp.action["source.addMissingImports.ts"], desc = "Add Missing Imports" },
            { "<leader>cu", LazyVim.lsp.action["source.removeUnused.ts"], desc = "Remove Unused" },
            { "<leader>cD", LazyVim.lsp.action["source.fixAll.ts"], desc = "Fix All" },
          },
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = {
                  enabled = "all",
                  suppressWhenArgumentMatchesName = false,
                },
                parameterTypes = { enabled = true },
                variableTypes = {
                  enabled = true,
                  suppressWhenTypeMatchesName = false,
                },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },
        vtsls = { enabled = false },
        ts_ls = { enabled = false },
        tsserver = { enabled = false },
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
        ltex = {
          settings = {
            ltex = {
              language = "ru-RU",
            },
          },
        },
      },
      setup = {
        tsgo = function(_, opts)
          local orig_on_attach = opts.on_attach
          opts.on_attach = function(client, bufnr)
            if orig_on_attach then
              orig_on_attach(client, bufnr)
            end

            local cap = client.server_capabilities.codeActionProvider
            local kinds = {
              "quickfix",
              "refactor",
              "refactor.extract",
              "refactor.inline",
              "refactor.rewrite",
              "source",
              "source.organizeImports",
              "source.organizeImports.ts",
              "source.addMissingImports",
              "source.fixAll",
              "source.addMissingImports.ts",
              "source.removeUnused",
              "source.removeUnused.ts",
            }

            if type(cap) == "table" then
              cap.codeActionKinds = kinds
              cap.resolveProvider = true
            else
              -- tsgo may omit codeActionProvider; force-enable so LazyVim keybinds work.
              client.server_capabilities.codeActionProvider = { codeActionKinds = kinds, resolveProvider = true }
            end
          end
        end,
      },
    },
  },
}

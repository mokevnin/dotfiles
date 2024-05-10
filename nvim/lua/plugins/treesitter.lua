return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- https://github.com/EmranMR/tree-sitter-blade/discussions/19
      -- https://github.com/calebdw/dotfiles/blob/master/.config/nvim/queries/blade/injections.scm
      vim.list_extend(opts.ensure_installed, {
        "php",
        "php_only",
      })

      opts.endwise = {
        enable = true,
      }
      opts.swap = {
        enable = true,
      }

      -- local tbl_filetypes = require("nvim-ts-autotag.internal").tbl_filetypes
      opts.autotag = {
        enable = true,
        -- filetypes = vim.list_extend(tbl_filetypes, { 'blade' })
      }

      opts.select = {
        enable = true,
      }
      opts.textobjects = {
        lsp_interop = {
          enable = true,
        },
      }

      -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      -- parser_config.blade = {
      --   install_info = {
      --     url = "https://github.com/EmranMR/tree-sitter-blade",
      --     files = { "src/parser.c" },
      --     branch = "main",
      --     generate_requires_npm = true,
      --     requires_generate_from_grammar = true,
      --   },
      --   filetype = "blade",
      -- }

      -- require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

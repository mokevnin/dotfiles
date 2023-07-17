Configure = function()
  require('nvim-treesitter.configs').setup {
    auto_install = true,
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    autotag = {
      enable = true,
    },
    matchup = {
      enable = true
    },
    highlight = {
      enable = true, -- false will disable the whole extension
    },
    indent = {
      enable = true
    },
    endwise = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = 'grn',
        scope_incremental = 'grc',
        node_decremental = 'grm',
      },
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = 'none',
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        include_surrounding_whitespace = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = { query = "@class.outer", desc = "Next class start" },
          --
          -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
          ["]o"] = "@loop.*",
          -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
          --
          -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
        -- Below will go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        -- Make it even more gradual by adding multiple queries and regex.
        goto_next = {
          ["]d"] = "@conditional.outer",
        },
        goto_previous = {
          ["[d"] = "@conditional.outer",
        }
      },
    },
  }
end

return Configure

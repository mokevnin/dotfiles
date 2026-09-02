return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.signature = opts.signature or {}
      opts.signature.enabled = true
      opts.signature.window = opts.signature.window or {}

      opts.keymap = opts.keymap or {}
      opts.keymap["<C-u>"] = opts.keymap["<C-u>"] or { "scroll_signature_up", "fallback" }
      opts.keymap["<C-d>"] = opts.keymap["<C-d>"] or { "scroll_signature_down", "fallback" }

      -- lazyvim.plugins.extras.lang.sql добавляет источник `dadbod` в
      -- глобальный default, а модуль ему даёт vim-dadbod-completion, который
      -- выключен в plugins/disabled.lua -- иначе blink падал бы в любом буфере
      opts.sources = opts.sources or {}
      if opts.sources.default then
        opts.sources.default = vim.tbl_filter(function(source)
          return source ~= "dadbod"
        end, opts.sources.default)
      end
      if opts.sources.providers then
        opts.sources.providers.dadbod = nil
      end
    end,
  },
}

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
    end,
  },
}

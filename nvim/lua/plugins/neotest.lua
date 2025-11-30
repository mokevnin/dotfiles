return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-golang"] = {
          testify_enabled = true,
        },
      },
    },
  },
}

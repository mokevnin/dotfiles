return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-golang"] = {
          testify_enabled = true,
          -- LazyVim включает его по умолчанию, но требует nvim-dap-go,
          -- а тот выключен в plugins/disabled.lua
          dap_go_enabled = false,
        },
      },
    },
  },
}

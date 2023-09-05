return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      cmd = {
        "jdtls",
        "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand("$HOME/.config/nvim/files/lombok.jar")),
      },
    },
  },
}

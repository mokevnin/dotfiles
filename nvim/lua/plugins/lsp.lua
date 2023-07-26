return {
	{
		"neovim/nvim-lspconfig",
		opts = {
      diagnostics = {
        underline = true,
        virtual_text = false,
        -- update_in_insert = true,
        -- float = {
        --   show_header = true,
        --   source = 'always',
        --   border = 'rounded',
        --   focusable = false,
        -- },
      },
			autoformat = false,
			servers = {
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

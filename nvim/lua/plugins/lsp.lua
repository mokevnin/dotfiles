return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				underline = true,
				virtual_text = false,
				float = {
					border = "rounded",
				},
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

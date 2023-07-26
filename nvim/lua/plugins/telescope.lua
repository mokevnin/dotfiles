return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				-- sorting_strategy = "ascending",
				mappings = {
					-- restore default behavior
					i = {
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
					n = {
					},
				},
			},
			pickers = {
				buffers = {
					ignore_current_buffer = true,
					sort_mru = true,
				},
			},
		},
	},
}

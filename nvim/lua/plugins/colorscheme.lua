return {
	{
		"marko-cerovac/material.nvim",
		config = function()
			require("material").setup({
				plugins = {
					"dap",
					"dashboard",
					-- "gitsigns",
					-- "hop",
					"indent-blankline",
					"lspsaga",
					"mini",
					"neogit",
					-- "neorg",
					"nvim-cmp",
					"nvim-navic",
					-- "nvim-tree",
					"nvim-web-devicons",
					-- "sneak",
					"telescope",
					"trouble",
					"which-key",
				},
			})
			vim.g.material_style = "deep ocean"
		end,
	},
}

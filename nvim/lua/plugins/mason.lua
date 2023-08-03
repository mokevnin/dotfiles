return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			table.insert(opts.ensure_installed, "kotlin-language-server")
		end,
	},
	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	opts = function(_, opts)
	-- 		local nls = require("null-ls")
	-- 		opts.sources = vim.list_extend(opts.sources, {
	-- 			nls.builtins.diagnostics.write_good,
	-- 		})
	-- 	end,
	-- },
}

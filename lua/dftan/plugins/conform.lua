return {
	"stevearc/conform.nvim",
	dependencies = { "williamboman/mason.nvim" },
	lazy = true,
	opts = {
		formatters_by_ft = {
			c = { "clang-format" },
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
		},
	},

	keys = {
		{
			"<leader>mp",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end,
			{ desc = "Format file or range (in visual mode)" },
		},
	},
}

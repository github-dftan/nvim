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
			html = { "prettierd" },
			css = { "prettierd" },
			cmake = { "cmake_format" },
			-- json = { "prettierd" },
			json = { "jq" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			markdown = { "prettierd" },
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

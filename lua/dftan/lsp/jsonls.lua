-- lsp/jsonls.lua
-- 配置 JSON Language Server
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["jsonls"] = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git", "package.json" },
	capabilities = capabilities,

	settings = {
		json = {
			schemas = require("schemastore").json.schemas(), -- 如果安装了 schemastore.nvim
			validate = { enable = true },
			format = { enable = true },
		},
	},
}

vim.lsp.enable("jsonls")

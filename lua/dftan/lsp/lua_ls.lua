
-- lsp/lua_ls.lua
-- 配置 Lua 语言服务器，用于 Lua 文件开发
local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config['luals'] = {
	-- Command and arguments to start the server.
	cmd = { 'lua-language-server' },

	-- Filetypes to automatically attach to.
	filetypes = { 'lua' },

	-- Sets the "root directory" to the parent directory of the file in the
	-- current buffer that contains either a ".luarc.json" or a
	-- ".luarc.jsonc" file. Files that share a root directory will reuse
	-- the connection to the same LSP server.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	capabilities = capabilities,
	-- Specific settings to send to the server. The schema for this is
	-- defined by the server. For example the schema for lua-language-server
	-- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		 Lua = {
		   runtime = {
		     version = 'LuaJIT',
		   },
		   diagnostics = {
			   globals = {'vim','Snacks'},
		   }
		 }
	 },
}
vim.lsp.enable('luals')

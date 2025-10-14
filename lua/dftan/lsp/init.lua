require("dftan/lsp/lua_ls")
require("dftan/lsp/clangd")
require("dftan/lsp/jsonls")
require("dftan/lsp/cmake")

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
-- 	callback = function(args)
-- 		local bufnr = args.buf
-- 		-- local function map(mode, lhs, rhs, desc)
-- 		-- 	vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
-- 		-- end
--
-- 		-- map("n", "gd", vim.lsp.buf.definition, "LSP: 跳转到定义")
-- 		-- map("n", "gD", vim.lsp.buf.declaration, "LSP: 跳转到声明")
-- 		-- map("n", "gi", vim.lsp.buf.implementation, "LSP: 跳转到实现")
-- 		-- map("n", "gr", vim.lsp.buf.references, "LSP: 跳转到引用")
-- 		-- map("n", "gt", vim.lsp.buf.type_definition, "LSP: 跳转到类型定义")
-- 		-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
-- 		-- 	buffer = bufnr,
-- 		-- 	desc = "[LSP] Show diagnostic",
-- 		-- })
-- 	end,
-- })

vim.diagnostic.config({
	virtual_text = true, -- 行尾直接显示诊断信息（默认就开启）
	signs = true, -- 左侧gutter显示E/W等符号
	underline = true, -- 问题代码下划线
	update_in_insert = false, -- 插入模式下不更新（可选）
})

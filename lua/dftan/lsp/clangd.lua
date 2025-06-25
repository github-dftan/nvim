-- lsp/clangd.lua
-- 配置 clangd，用于 C/C++/ObjC 文件
local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config['clangd'] = {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = {'compile_commands.json', '.clangd', '.clang-tidy', '.git' },
  capabilities = capabilities,
  settings = {},
}

vim.lsp.enable('clangd')

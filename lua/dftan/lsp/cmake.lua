-- lsp/cmake.lua
-- 配置 cmake-language-server，用于 CMakeLists.txt 和 .cmake 文件
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config["cmake"] = {
	cmd = {
		"cmake-language-server",
	},
	filetypes = { "cmake" },
	root_markers = {
		"CMakeLists.txt",
		"cmake.lock",
		".git",
	},
	capabilities = capabilities,
	init_options = {
		-- 配置 CMake 构建目录
		-- buildDirectory = "build",
		-- 可选：指定 CMake 可执行文件路径（如果不在 PATH 中）
		-- cmakePath = "/usr/local/bin/cmake"
	},
	settings = {
		-- 可以添加额外的 CMake 配置选项
	},
}

vim.lsp.enable("cmake")

---@alias snacks.Config table //消除@type snacks.Config警告
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		animate = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = true },
		indent = {
			enabled = true,
			chunk = {
				-- when enabled, scopes will be rendered as chunks, except for the top-level scope which will be rendered as a scope.
				enabled = true,
			},
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		picker = {
			enabled = true,
			matcher = {
				fuzzy = true, -- use fuzzy matching
				smartcase = true, -- use smartcase
				ignorecase = true, -- use ignorecase
				sort_empty = false, -- sort results when the search string is empty
				filename_bonus = true, -- give bonus for matching file names (last part of the path)
				file_pos = true, -- support patterns like `file:line:col` and `file:line`
				-- the bonusses below, possibly require string concatenation and path normalization,
				-- so this can have a performance impact for large lists and increase memory usage
				cwd_bonus = false, -- give bonus for matching files in the cwd
				frecency = false, -- frecency bonus
				history_bonus = false, -- give more weight to chronological order
			},
		},
		quickfile = { enabled = true },
		scope = { enabled = true },
		-- scroll = { enabled = true },--平滑滚动
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
			},
			-- terminal = {
			-- 	relative = "editor",
			-- 	border = "rounded",
			-- 	position = "float",
			-- 	backdrop = 60, --不透明度
			-- 	height = 0.9,
			-- 	width = 0.9,
			-- 	zindex = 50, --层级索引，数字越大越靠前（即更“浮”在前面）。50 是一个中等层级
			-- },
		},

		terminal = {
			win = {
				position = "float",
				relative = "editor",
				border = "rounded",
				backdrop = 60, --不透明度
				height = 0.9,
				width = 0.9,
				zindex = 50,
			},
		}, --层级索引，数字越大越靠前（即更“浮”在前面）。50 是一个中等层级} },
		win = {
			enabled = true,
			input = {
				keys = {
					["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } }, --隐藏文件显示或者隐藏
					["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } }, -- 显示或者隐藏忽视的文件
				},
			},
		},
	},
	-- stylua: ignore
	keys = {
        { "<A-t>", function() require("snacks").terminal() end, desc = "[Snacks] Toggle terminal", mode = {"n", "t"} },
		-- find
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- Notification
        { "<leader>sn", function() require("snacks").picker.notifications() end, desc = "[Snacks] Notification history" },
        { "<leader>n", function() require("snacks").notifier.show_history() end, desc = "[Snacks] Notification history" },
        { "<leader>un", function() require("snacks").notifier.hide() end, desc = "[Snacks] Dismiss all notifications" },
		-- Grep
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

		-- Top Pickers & Explorer
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

        --LSP
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },

        --diagnostics
        { "<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "[Snacks] Diagnostics" },
        { "<leader>sD", function() require("snacks").picker.diagnostics_buffer() end, desc = "[Snacks] Diagnostics buffer" },
		-- Other
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
	},
	init = function()
		local Snacks = require("snacks")
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Snacks.dim.enable() -- 启用暗淡未使用的文本
				Snacks.toggle.dim():map("<leader>tD")
			end,
		})
	end,
}

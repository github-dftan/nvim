--Copilot 需要安装nodejsV20以上
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VeryLazy",
		-- opts = {
		-- 	suggestion = { enabled = true },
		-- 	panel = { enabled = true },
		-- 	filetypes = {
		-- 		markdown = true,
		-- 		help = true,
		-- 	},
		-- },
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true, -- 自动触发建议
				keymap = {
					accept = "<C-y>",
					next = "<C-j>",
					prev = "<C-k>",
					dismiss = "<Esc>",
					accept_line = "<C-i>",
					accept_word = "<C-l>", -- 你可以自定义
				},
			},
			panel = { enabled = true },
		},
	},

	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.diff",
			"j-hui/fidget.nvim",
		},
		--AI对话的时候显示进度
		init = function()
			require("dftan.utils.codecompanion_fidget_spinner"):init()
		end,

		-- stylua: ignore
		   keys = {
		     {"<leader>cca", "<CMD>CodeCompanionActions<CR>",     mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion actions"      },
            --gr 拒绝更改 ga 接受更改
		     {"<leader>cci", "<CMD>CodeCompanion<CR>",            mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion inline"       },
            --ga聊天界面可以换模型
		     {"<leader>ccc", "<CMD>CodeCompanionChat Toggle<CR>", mode = {"n", "v"}, noremap = true, silent = true, desc = "CodeCompanion chat (toggle)"},
		     {"<leader>ccp", "<CMD>CodeCompanionChat Add<CR>",    mode = {"v"}     , noremap = true, silent = true, desc = "CodeCompanion chat add code"},
		   },

		-- 配置显示选项
		-- diff 表示差异显示相关的设置
		opts = {
			display = {
				diff = {
					enabled = true, -- 启用差异显示
					provider = "mini_diff", -- 使用 mini_diff 作为差异提供者
				},
			},

			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
			},

			opts = {
				language = "Chinese", -- "English"|"Chinese"
			},
		},
	},
}

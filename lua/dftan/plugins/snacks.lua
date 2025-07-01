
---@alias snacks.Config table //消除@type snacks.Config警告
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				-- Used by the `header` section
-- 				header = [[
--
--                           ...      ...                  .:#=.       ..             .      .-*##*:.                       :++..                     
--                           -%%+:    .-@%=.          .+=.  :%@#:  ..+%@:             *@+..+@@@%%@@%.        ..            .=@%=.:##=.                
--                      ..   :%@%+.   .-@@#-.        .-%#-. .*@@=-%@@@%:.             :@@@@%+..:#%@@*.      +**=:..       .*@@+=#*%@@+.               
--                     .*#:  :%@@%-   .-@@@+.       .-%@#-:-=#@@@@%*=..               :@@%=.  .=+@@%+.     .%@@@#:.  ..-+.+@#-::.:@@@*:               
--                    .*@#:  .%@@@+-+*%@@@@+.    .:+%@@%#%@@%%@@%:..:-.          .++:+%@@%- ..:*%@@*+.     .=**-.:=+*%@%=..:#%%@-*@@@+.               
--                    -%@#=-+*%@@@@@@@@%@@%-.    .-%@@*......-@@@%%@@%-          .*@%%=%@%*#%:*#@@@=:      ..+*=.:*@@@*:. .*@*-:=%@@%-.               
--                    .*@@@@@@@@@@*-:..=@@*.         .:-=+#@@@@@@@@%+.           .*@%++%@@#-.*#@@@+=.       .+%=. .:+@@*+-.%%+.*@@@@*.                
--                      .:::..#@@@=.*%#=...           .=*#%##%@@#.               :#@%:.%@%=.*#@@@*=:.       ..  .-#%@@@@%#:%@@%#@@%*:                 
--                      .-*%=:%@@%=..#@@*:       .:-:.......:%@@-..........      .*%#%#%@@@@@@@@%=:.        .:-+#@+..:..  ..===+%@*.                  
--                      :%@*:-%@@%##%@@@@=.       .=%%%%#####@@%##########-         .:=%@@%%+*+=..          .-+++:.     :+***#=.=@%+.                 
--                      -@@@@@@@@@@@@%%@@*.         ..-++#%@@@@@@@@@@@@@@%-            .+@@%%#==++=+.                     .....=%@@#:                 
--                      ..-+###+-:... .+%=.                ............                ..=*@@@@@@@@#.                       .=%@@@#.                  
--                                                                                         .:=**#%#-.                         -*+:                    
--
-- ]],
			},
			sections = {
				{ section = "header" },
				{ section = "keys", padding = 1 },
				{ section = "recent_files", title = "Recent files", padding = 1 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = true },
		picker = {
			enabled = true,
		},
		quickfile = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
		-- scope = { enabled = true },
		-- indent = { enabled = true },
		-- input = { enabled = true }, -- 对于输入，会弹出一个浮窗
		-- notifier = { enabled = true },
		-- scroll = { enabled = true },
		-- animate ={enabled = true},
		bufdelete = { enabled = true },
		-- debug ={enabled = true},
		-- dim ={enabled = true},
		-- git ={enabled = true},
		-- gitbrowse ={enabled = true},
		-- image ={enabled = true},
		-- layout ={enabled = true},
		-- lazygit ={enabled = true},
		-- notify ={enabled = true},
		-- profiler ={enabled = true},
		-- rename ={enabled = true},
		-- scratch ={enabled = true},
		-- terminal ={enabled = true},
		-- toggle ={enabled = true},
		-- util ={enabled = true},
		-- win ={enabled = true},
		-- zen ={enabled = true},
	},

	-- stylua: ignore
	keys = {
		-- find
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
		{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },

		-- Grep
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

		-- Top Pickers & Explorer
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

		-- Other
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
	}
,
}

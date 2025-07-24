--状态栏插件
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		-- "nvim-tree/nvim-web-devicons",
		"AndreM222/copilot-lualine",
	},
	opts = {
		options = {
			theme = "catppuccin",
			always_divide_middle = false,
			-- section_separators = { left = "", right = "" },
			-- component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			globalstatus = false, --true时候使用统一的状态栏
			--进入调试模式时不显示winbar，否则会覆盖调试按钮
			disabled_filetypes = {
				winbar = { "dap-repl", "dapui_watches", "dapui_stacks", "dapui_breakpoints", "dapui_scopes" },
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename"}, -- 显示文件路径，`path = 1` 表示相对路径，改为 `path = 3` 可显示绝对路径
			lualine_x = {},
			lualine_y = { "encoding", "fileformat", "filetype", "progress" },
			lualine_z = { "location" },
		},
		extensions = { "nvim-dap-ui" },
      -- stylua: ignore
      winbar = {
        lualine_a = { "filename" },
        lualine_b = { { function() return " " end, color = "Comment", }, },
        lualine_x = { "lsp_status", },
      },
		inactive_winbar = {
        -- Always show winbar
        -- stylua: ignore
        lualine_b = { function() return " " end, },
		},
	},
	config = function(_, opts)
		local mocha = require("catppuccin.palettes").get_palette("mocha")

		--把copilot的状态在lualine中显示出来
		local copilot = {
			"copilot",
			show_colors = true,
			symbols = {
				status = {
					hl = {
						enabled = mocha.green,
						sleep = mocha.overlay0,
						disabled = mocha.surface0,
						warning = mocha.peach,
						unknown = mocha.red,
					},
				},
				spinner_color = mocha.mauve,
			},
		}
		table.insert(opts.sections.lualine_c, copilot)

		local function dap_statusline()
			local dap = require("dap")
			if dap.session() then
				return "  " .. dap.status()
			end
			return ""
		end
		table.insert(opts.sections.lualine_c, dap_statusline)
		-- local lap_buttons = {
		-- 	"disconnect",
		-- 	icons_enabled = true,
		-- 	icon = "",
		-- 	on_click = require("dap").disconnect,
		-- }
		-- local function dap_buttons()
		-- 	local dap = require("dap")
		-- 	if dap.session() then
		-- 		return lap_buttons
		-- 	end
		-- 	return ""
		-- end
		-- table.insert(opts.sections.lualine_c, dap_buttons)
		require("lualine").setup(opts)
	end,
}

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons", "AndreM222/copilot-lualine" },
--
-- 	config = function()
-- 		local mocha = require("catppuccin.palettes").get_palette("mocha")
-- 		--把copilot的状态在lualine中显示出来
-- 		local copilot = {
-- 			"copilot",
-- 			show_colors = true,
-- 			symbols = {
-- 				status = {
-- 					hl = {
-- 						enabled = mocha.green,
-- 						sleep = mocha.overlay0,
-- 						disabled = mocha.surface0,
-- 						warning = mocha.peach,
-- 						unknown = mocha.red,
-- 					},
-- 				},
-- 				spinner_color = mocha.mauve,
-- 			},
-- 		}
-- 		require("lualine").setup({
-- 			options = {
-- 				theme = "catppuccin",
-- 				disabled_filetypes = {
-- 					winbar = { "dap-repl", "dapui_watches", "dapui_stacks", "dapui_breakpoints", "dapui_scopes" },
-- 				},
-- 			},
-- 			sections = {
-- 				lualine_c = {
-- 					{ "filename", path = 3 }, -- 显示文件路径，`path = 1` 表示相对路径，改为 `path = 3` 可显示绝对路径
-- 					copilot,
-- 				},
-- 			},
-- 			winbar = {
-- 				lualine_a = { "filename" },
-- 			},
-- 		})
-- 	end,
-- }

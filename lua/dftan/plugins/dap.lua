return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "C:/Users/dftan/AppData/Local/nvim/vscode_cpptools/extension/debugAdapters/bin/OpenDebugAD7",
				options = { detached = false },
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
				{
					name = "Attach to gdbserver :2331",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:2331",
					miDebuggerPath = "/usr/bin/gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
				},
				{
					name = "debug by openocd",
					type = "cppdbg",
					request = "launch",
					preLaunchTask = "build",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:3333",
					miDebuggerPath = "arm-none-eabi-gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					stopAtEntry = false,
					postRemoteConnectCommands = {
						{
							tex = function()
								-- return "load" .. vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                                return "load"
							end,
						},
						{
							text = "monitor reset halt",
						},
						{
							text = "monitor rtt stop",
							ignoreFailures = true,
						},
						{
							text = "monitor rtt server stop 9090",
						},
						{
							text = "monitor rtt start 9090 0k",
						},
						{
							text = 'monitor rtt setup 0x20000000 0x00000030 "SEGGER RTT"',
						},
						{
							text = "monitor rtt start",
						},
					},
					setupCommands = {
						{
							description = "Enable pretty-printing",
							text = "-enable-pretty-printing",
							ignoreFailures = true,
						},
					},
				},

				{
					name = "debug by jlink",
					type = "cppdbg",
					request = "launch",
					preLaunchTask = "build", -- 你可以在 tasks.json 或手动触发构建
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:2331", -- J-Link 默认端口
					miDebuggerPath = "arm-none-eabi-gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					stopAtEntry = false,
					postRemoteConnectCommands = {
						{
							text = function()
								return "load"
							end,
						},
						{
							text = "monitor reset",
						},
						{
							text = "monitor halt",
						},
					},
					setupCommands = {
						{
							description = "Enable pretty-printing",
							text = "-enable-pretty-printing",
							ignoreFailures = true,
						},
					},
				},
			}
			dap.configurations.c = dap.configurations.cpp
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text", "nvim-neotest/nvim-nio" },
		keys = {
			"<leader>db",
			"<leader>ds",
			"<leader>du",
		},
		config = function()
			require("nvim-dap-virtual-text").setup() -- optional
			require("dap")
			local dap, dapui = require("dap"), require("dapui")

			dap.listeners.before.attach.dapui_config = function()
				-- require("lualine").hide() --关掉lualine不然调试按钮显示不出来
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				-- require("lualine").hide()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				-- require("lualine").hide({ unhide = true })
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				-- require("lualine").hide({ unhide = true })
				dapui.close()
			end
			-- customize UI layout
			dapui.setup({
				layouts = {
					{
						position = "left",
						size = 0.2,
						elements = {
							{ id = "stacks", size = 0.2 },
							{ id = "scopes", size = 0.5 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "watches", size = 0.15 },
						},
					},
					{
						position = "bottom",
						size = 10,
						elements = {
							{ id = "repl", size = 0.2 },
							{ id = "console", size = 0.5 },
						},
					},
				},
			})
			-- Custom breakpoint icons
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "",
				texthl = "DapBreakpointCondition",
				linehl = "DapBreakpointCondition",
				numhl = "DapBreakpointCondition",
			})
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)

			-- keymaps
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
			vim.keymap.set("n", "<leader>ds", dap.continue, { desc = " Start/Continue" })
			vim.keymap.set("n", "<F1>", dap.continue, { desc = " Start/Continue" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = " Step into" })
			vim.keymap.set("n", "<F2>", dap.step_into, { desc = " Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = " Step over" })
			vim.keymap.set("n", "<F3>", dap.step_over, { desc = " Step over" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = " Step out" })
			vim.keymap.set("n", "<F4>", dap.step_out, { desc = " Step out" })
			vim.keymap.set("n", "<leader>dq", dap.close, { desc = "DAP: Close session" })
			vim.keymap.set("n", "<leader>dQ", dap.terminate, { desc = " Terminate session" })
			vim.keymap.set("n", "<leader>dr", dap.restart_frame, { desc = "DAP: Restart" })
			vim.keymap.set("n", "<F5>", dap.restart_frame, { desc = "DAP: Restart" })

			vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
			vim.keymap.set("n", "<leader>dR", dap.repl.toggle, { desc = "DAP: Toggle REPL" })
			vim.keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "DAP: Hover" })

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				local input = vim.fn.input("Condition for breakpoint:")
				dap.set_breakpoint(input)
			end, { desc = "DAP: Conditional Breakpoint" })
			vim.keymap.set("n", "<leader>dD", dap.clear_breakpoints, { desc = "DAP: Clear Breakpoints" })
		end,
	},
}

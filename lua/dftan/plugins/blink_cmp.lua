--这是一个补全插件
return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
	-- dependencies = { "rafamadriz/friendly-snippets" },
	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "none", --取消默认
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "accept", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500, --500ms后显示文档
			},
			keyword = {

				-- 'prefix' will fuzzy match on the text before the cursor
				-- 'full' will fuzzy match on the text before _and_ after the cursor
				-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
				range = "full",
			},
			list = {
				-- Maximum number of items to display
				max_items = 200,
				selection = {
					-- When `true`, will automatically select the first item in the completion list
					preselect = false,
					-- preselect = function(ctx) return vim.bo.filetype ~= 'markdown' end,

					-- When `true`, inserts the completion item automatically when selecting it
					-- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
					-- which will both undo the selection and hide the completion menu
					auto_insert = true,
					-- auto_insert = function(ctx) return vim.bo.filetype ~= 'markdown' end
				},
			},
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = function()
				local success, node = pcall(vim.treesitter.get_node)
				if
					success
					and node
					and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
				then
					return { "buffer" }
				else
					return { "copilot", "lsp", "path", "snippets", "buffer" }
				end
			end,
			providers = { -- 补全的优先级.数字越大优先级越高
				buffer = { score_offset = 3 },
				lsp = { score_offset = 2 },
				path = { score_offset = 1 },
				snippets = { score_offset = 0 },
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
					opts = {
						kind_icon = "",
						kind_hl = "DevIconCopilot",
					},
				},
				cmdline = {
					min_keyword_length = function(ctx)
						-- when typing a command, only show when the keyword is 3 characters or longer
						if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
							return 3
						end
						return 0
					end,
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = "single", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
				winblend = 0,
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
				-- Which directions to show the window,
				-- falling back to the next direction when there's not enough space,
				-- or another window is in the way
				direction_priority = { "n" },
				-- Disable if you run into performance issues
				treesitter_highlighting = true,
				show_documentation = true,
			},
		},
		--命令行提示与补全
		cmdline = {
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
						-- enable for inputs as well, with:
						-- or vim.fn.getcmdtype() == '@'
					end,
				},
				ghost_text = { enabled = false },
			},
			keymap = {
				["<CR>"] = { "select_and_accept", "fallback" }, --回车不马上执行
			},
		},
		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

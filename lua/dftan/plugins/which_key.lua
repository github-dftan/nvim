--显示按键提示
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		---@type false | "classic" | "modern" | "helix"
		preset = "helix",
		win = {
			-- no_overlap = true,
			title = false,
			width = 0.5,
		},
      -- stylua: ignore
      spec = {
        { "<leader>cc", group = "<CodeCompanion>", icon = "" },
        { "<leader>s",  group = "<Snacks>"                    },
        { "<leader>t",  group = "<Snacks> Toggle"             },
      },
		-- expand all nodes wighout a description
		expand = function(node)
			return not node.desc
		end,
	},
	keys = {
      -- stylua: ignore
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "[Which-key] Buffer Local Keymaps", },
	},
}

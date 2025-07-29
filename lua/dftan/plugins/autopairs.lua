--括号自动分开和匹配
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
	},
}

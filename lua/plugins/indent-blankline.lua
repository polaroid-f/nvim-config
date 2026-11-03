return{
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",

		main = "ibl",

		opts = {
			indent = {
					char = "│",
					tab_char = "│",
			},
			-- 好像自带并且需要 treesitter，安装 treesitter 后再看
			-- scope = { show_start = true, show_end = true },
			whitespace = {
				remove_blankline_trail = false,
			},
			scope = { enabled = false},
		},
	}
}

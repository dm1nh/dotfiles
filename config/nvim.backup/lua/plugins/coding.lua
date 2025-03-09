return {
	{
		"hrsh7th/nvim-cmp",
		opts = {
			completion = {
				completeopt = "menu,menuone,noselect", -- NOTE: I need to add noselect to keep Gdscript completion
			},
			matching = {
				disallow_prefix_unmatching = true,
			},
		},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
	},
}

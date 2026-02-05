return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function(_, opts)
		require("tokyonight").setup()
		vim.cmd.colorscheme("tokyonight-moon")
	end,
}

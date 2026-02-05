return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				texlab = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.highlight = opts.highlight or {}
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "bibtex" })
			end
			if type(opts.highlight.disable) == "table" then
				vim.list_extend(opts.highlight.disable, { "latex" })
			else
				opts.highlight.disable = { "latex" }
			end
		end,
	},
	{
		"lervag/vimtex",
		lazy = false, -- lazy-loading will disable inverse search
		config = function()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_method = "tectonic"
			vim.g.vimtex_compiler_tectonic = {
				options = {
					"-X",
					"compile",
					"--keep-intermediates",
					"--keep-logs",
					"--synctex",
				},
			}
			vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
			vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
			vim.g.vimtex_quickfix_open_on_warning = 0
		end,
		keys = {
			{ "<localleader>l", "", desc = "Vimtex", ft = "tex" },
		},
	},
}

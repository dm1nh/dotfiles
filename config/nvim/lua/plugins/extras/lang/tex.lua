return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = { "tex", "plaintex", "bib" },
			root = { ".latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
		})
	end,

	-- Add BibTeX/LaTeX to treesitter
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

	-- {
	-- 	"lervag/vimtex",
	-- 	lazy = false, -- lazy-loading will disable inverse search
	-- 	config = function()
	-- 		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
	-- 		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
	-- 	end,
	-- 	keys = {
	-- 		{ "<localLeader>l", "", desc = "+vimtex", ft = "tex" },
	-- 	},
	-- },

	{
		"let-def/texpresso.vim",
		keys = {
			{ "<Leader>cx", "<cmd>TeXpresso expand('%:p')<cr>", desc = "Build texpresso", silent = true },
		},
	},

	-- Correctly setup lspconfig for LaTeX 🚀
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				texlab = {
					settings = {
						texlab = {
							build = {
								executable = "tectonic",
								args = {
									"-X",
									"compile",
									"%f",
									"--synctex",
									"--keep-logs",
									"--keep-intermediates",
								},
							},
							latexFormatter = "tex-fmt",
							bibtexFormatter = "tex-fmt",
						},
					},
					keys = {
						{ "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
						{ "<Leader>cb", "<cmd>TexlabBuild<cr>", desc = "Build", silent = true },
					},
				},
			},
		},
	},
}

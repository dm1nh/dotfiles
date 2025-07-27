return {
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters = {
				["tex"] = "tex-fmt",
				["plaintex"] = "tex-fmt",
				["bib"] = "tex-fmt",
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = { ensure_installed = { "tectonic", "tex-fmt" } },
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				["texlab"] = {
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
				},
			},
		},
	},
}

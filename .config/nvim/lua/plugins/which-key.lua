return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
	opts = {
		preset = "helix",
		defaults = {},
		icons = {
			separator = "󰅂",
			group = "+",
			mappings = false,
		},
		-- Document existing key chains
		spec = {
			{
				mode = { "n", "x" },
				{ "<leader><leader>", name = "Files" },
				{ "<leader><TAB>",    group = "Tabs" },
				{ "<leader>c",        group = "Code" },
				{ "<leader>d",        group = "Debug" },
				{ "<leader>f",        group = "Files" },
				{ "<leader>s",        group = "Search" },
				{ "<leader>t",        group = "Toggle" },
				{ "<leader>g",        group = "Git" },
				{ "<leader>gh",       group = "Hunk" },
				{ "<leader>q",        group = "Session" },
				{ "<leader>u",        group = "UI" },
				{ "<leader>x",        group = "Diag" },
				{ "<leader>/",        name = "Grep" },
				{ "<leader>[",        group = "Prev" },
				{ "<leader>]",        group = "Next" },
				{ "g",                group = "Goto" },
				{ "gs",               group = "Surround" },
				{ "z",                group = "Fold" },
				{
					"<leader>b",
					group = "Buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				{
					"<leader>w",
					group = "Windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				-- better descriptions
				{ "gx", desc = "Open with system app" },
			},
		},
	},
}

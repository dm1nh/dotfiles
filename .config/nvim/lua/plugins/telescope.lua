return {
-- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-tree/nvim-web-devicons" },
	},
	keys = function()
		local builtin = require("telescope.builtin")
		return {
			{
				"<leader><leader>",
				function()
					builtin.find_files({ hidden = true })
				end,
				desc = "Files",
			},
			{
				"<leader>/",
				function()
					builtin.live_grep({ hidden = true })
				end,
				desc = "Grep",
			},

			-- find
			{
				"<leader>fb",
				function()
					builtin.buffers({ sort_mru = true, sort_lastused = true, ignore_current_buffer = true })
				end,
				desc = "Buffers",
			},
			{
				"<leader>fB",
				builtin.buffers,
				desc = "Buffers (all)",
			},
			{
				"<leader>ff",
				function()
					builtin.find_files({ hidden = true })
				end,
				desc = "Files",
			},
			{ "<leader>fg", builtin.find_files, desc = "Git files" },
			{ "<leader>fr", builtin.oldfiles, desc = "Recent files" },

			-- git
			{ "<leader>gc", builtin.git_commits, desc = "Commits" },
			{ "<leader>gs", builtin.git_status, desc = "Status" },
			{ "<leader>gS", builtin.git_stash, desc = "Stash" },

			-- search
			{ '<leader>s"', builtin.registers, desc = "Registers" },
			{ "<leader>s/", builtin.search_history, desc = "Search history" },
			{ "<leader>sa", builtin.autocommands, desc = "Autocommands" },
			{ "<leader>sb", builtin.current_buffer_fuzzy_find, desc = "Buffer lines" },
			{ "<leader>sc", builtin.command_history, desc = "Command history" },
			{ "<leader>sC", builtin.commands, desc = "Commands" },
			{ "<leader>sd", builtin.diagnostics, desc = "Diagnostics" },
			{
				"<leader>sd",
				function()
					builtin.diagnostics({ bufnr = 0 })
				end,
				desc = "Diagnostics (buffer)",
			},
			{
				"<leader>sg",
				function()
					builtin.live_grep({ hidden = true })
				end,
				desc = "Grep",
			},
			{ "<leader>sh", builtin.help_tags, desc = "Help tags" },
			{ "<leader>sk", builtin.keymaps, desc = "Keymaps" },
			{ "<leader>sw", builtin.grep_string, desc = "Search current word" },
			{ "<leader>sR", builtin.resume, desc = "Resume" },
			{ "<leader>sq", builtin.quickfix, desc = "Quickfix list" },

			{ "<leader>xx", builtin.diagnostics, desc = "Diagnostics" },
		}
	end,
	config = function()
		require("telescope").setup({})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
	end,
}

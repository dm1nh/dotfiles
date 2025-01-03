return {
	{ -- disable neotree
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},

	{ -- override mini.files
		"echasnovski/mini.files",
		keys = {
			{
				"<leader>e",
				function()
					if not require("mini.files").close() then
						require("mini.files").open(vim.uv.cwd(), true)
					end
				end,
				desc = "Explorer (cwd)",
			},
			{
				"<leader>E",
				function()
					if not require("mini.files").close() then
						require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
					end
				end,
				desc = "Explorer (Current File)",
			},
		},
		config = function(_, opts)
			local hidden_by_default = { "node_modules", ".git", "build", "dist", ".build" }

			local show_dots = false
			local filter_show = function(fs_entry)
				return true
			end
			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".") and not vim.tbl_contains(hidden_by_default, fs_entry.name)
			end

			require("mini.files").setup({
				window = { preview = false },
				content = { filter = filter_hide },
			})

			local toggle_dots = function()
				show_dots = not show_dots
				local new_filter = show_dots and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end
			local map_split = function(buf_id, lhs, direction, close_on_file)
				local rhs = function()
					local new_target_window
					local cur_target_window = require("mini.files").get_target_window()
					if cur_target_window ~= nil then
						vim.api.nvim_win_call(cur_target_window, function()
							vim.cmd("belowright " .. direction .. " split")
							new_target_window = vim.api.nvim_get_current_win()
						end)

						require("mini.files").set_target_window(new_target_window)
						require("mini.files").go_in({ close_on_file = close_on_file })
					end
				end

				local desc = "Open in " .. direction .. " split"
				if close_on_file then
					desc = desc .. " and close"
				end
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			local files_set_cwd = function()
				local cur_entry_path = MiniFiles.get_fs_entry().path
				local cur_directory = vim.fs.dirname(cur_entry_path)
				if cur_directory ~= nil then
					vim.fn.chdir(cur_directory)
				end
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id

					vim.keymap.set(
						"n",
						opts.mappings and opts.mappings.toggle_hidden or "g.",
						toggle_dots,
						{ buffer = buf_id, desc = "Toggle hidden files" }
					)

					vim.keymap.set(
						"n",
						opts.mappings and opts.mappings.change_cwd or "gc",
						files_set_cwd,
						{ buffer = args.data.buf_id, desc = "Set cwd" }
					)

					map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
					map_split(
						buf_id,
						opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
						"horizontal",
						true
					)
					map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					LazyVim.lsp.on_rename(event.data.from, event.data.to)
				end,
			})
		end,
	},

	{ -- override which-key
		"folke/which-key.nvim",
		opts = {
			icons = {
				mappings = false,
			},
			show_help = false,
			show_keys = false,
		},
	},

	{ -- override telescope
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				file_ignore_patterns = { "node_modules", "build", "dist" },
			},
		},
	},
}

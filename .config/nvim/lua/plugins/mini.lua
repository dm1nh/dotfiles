return {
	{
		"nvim-mini/mini.comment",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.icons",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.files",
		version = "*",
		keys = {
			{ "<leader>e", "<cmd>lua MiniFiles.open()<cr>", desc = "Tree" },
		},
		config = function()
			local MiniFiles = require("mini.files")

			-- Transparent window
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesWindowOpen",
				callback = function(args)
					local win_id = args.data.win_id

					-- Customize window-local settings
					vim.wo[win_id].winblend = 10
					local config = vim.api.nvim_win_get_config(win_id)
					config.border, config.title_pos = "double", "right"
					vim.api.nvim_win_set_config(win_id, config)
				end,
			})

			-- Toggle dotfiles
			local show_dotfiles = false

			local filter_show = function(fs_entry)
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				MiniFiles.refresh({ content = { filter = new_filter } })
			end

			-- split windows
			local map_split = function(buf_id, lhs, direction)
				local rhs = function()
					-- Make new window and set it as target
					local cur_target = MiniFiles.get_explorer_state().target_window
					local new_target = vim.api.nvim_win_call(cur_target, function()
						vim.cmd(direction .. " split")
						return vim.api.nvim_get_current_win()
					end)

					MiniFiles.set_target_window(new_target)

					-- This intentionally doesn't act on file under cursor in favor of
					-- explicit "go in" action (`l` / `L`). To immediately open file,
					-- add appropriate `MiniFiles.go_in()` call instead of this comment.
				end

				-- Adding `desc` will result into `show_help` entries
				local desc = "Split " .. direction
				vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Tweak left-hand side of mapping to your liking
					vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
					-- Tweak keys to your liking
					map_split(buf_id, "<C-s>", "belowright horizontal")
					map_split(buf_id, "<C-v>", "belowright vertical")
					map_split(buf_id, "<C-t>", "tab")
				end,
			})

			MiniFiles.setup()
		end,
	},
	{
		"nvim-mini/mini.hipatterns",
		version = "*",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				-- custom LazyVim option to enable the tailwind integration
				tailwind = {
					enabled = true,
					ft = {
						"astro",
						"css",
						"heex",
						"html",
						"html-eex",
						"javascript",
						"javascriptreact",
						"rust",
						"svelte",
						"typescript",
						"typescriptreact",
						"vue",
					},
					-- full: the whole css class will be highlighted
					-- compact: only the color will be highlighted
					style = "full",
				},
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
					shorthand = {
						pattern = "()#%x%x%x()%f[^%x%w]",
						group = function(_, _, data)
							---@type string
							local match = data.full_match
							local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
							local hex_color = "#" .. r .. r .. g .. g .. b .. b

							return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
						end,
						extmark_opts = { priority = 2000 },
					},
				},
			}
		end,
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.starter",
		version = "*",
		event = "VimEnter",
		opts = function()
			local logo = table.concat({
				" ┓   ┓  ┓",
				"┏┫┏┳┓┃┏┓┣┓",
				"┗┻┛┗┗┻┛┗┛┗",
			}, "\n")
			local pad = string.rep(" ", 0)
			local new_section = function(name, action, section)
				return { name = name, action = action, section = pad .. section }
			end

			local starter = require("mini.starter")
			--stylua: ignore
			local config = {
				evaluate_single = true,
				header = logo,
				footer = "",
				items = {
					new_section("New file", "ene | startinsert", "Built-in"),
					new_section("Restore session", [[lua require("persistence").load()]], "Session"),
					new_section("Lazy", "Lazy", "Config"),
					new_section("Quit", "qa", "Built-in"),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(pad .. "░ ", false),
					starter.gen_hook.aligning("center", "center"),
				},
			}
			return config
		end,
		config = function(_, config)
			-- close Lazy and re-open when starter is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "MiniStarterOpened",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			local starter = require("mini.starter")
			starter.setup(config)
		end,
	},
}

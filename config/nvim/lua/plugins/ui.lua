return {
	{ -- disable tabline
		"akinsho/bufferline.nvim",
		enabled = false,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			-- PERF: we don't need this lualine require madness 🤷
			local lualine_require = require("lualine_require")
			lualine_require.require = require

			local icons = LazyVim.config.icons

			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						LazyVim.lualine.root_dir(),
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ LazyVim.lualine.pretty_path() },
					},
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
					},
					lualine_x = {
						Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						"branch",
					},
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			}

			-- do not add trouble symbols if aerial is enabled
			-- And allow it to be overriden for some buffer types (see autocmds)
			if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
				local trouble = require("trouble")
				local symbols = trouble.statusline({
					mode = "symbols",
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					hl_group = "lualine_c_normal",
				})
				table.insert(opts.sections.lualine_c, {
					symbols and symbols.get,
					cond = function()
						return vim.b.trouble_lualine ~= false and symbols.has()
					end,
				})
			end

			return opts
		end,
	},

	{
		"echasnovski/mini.icons",
		opts = {
			directory = require("config.defaults").override_icons.directory,
			file = require("config.defaults").override_icons.file,
			filetype = require("config.defaults").override_icons.filetype,
			extension = require("config.defaults").override_icons.extension,
		},
	},

	{ -- dashboard
		"folke/snacks.nvim",
		opts = {
			dashboard = {
				preset = {
					header = [[
██████╗ ███╗   ███╗ ██╗███╗   ██╗██╗  ██╗
██╔══██╗████╗ ████║███║████╗  ██║██║  ██║
██║  ██║██╔████╔██║╚██║██╔██╗ ██║███████║
██║  ██║██║╚██╔╝██║ ██║██║╚██╗██║██╔══██║
██████╔╝██║ ╚═╝ ██║ ██║██║ ╚████║██║  ██║
╚═════╝ ╚═╝     ╚═╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝
      ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = "󰍉 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "󰺮 ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰒓 ", key = "c", desc = "Configuration", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󱍷 ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = "󰈆 ", key = "q", desc = "Quit Neovim", action = ":qa" },
          },
				},
			},
		},
	},
}
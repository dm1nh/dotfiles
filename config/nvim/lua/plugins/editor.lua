return {
  { -- https://github.com/MagicDuck/grug-far.nvim
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "v" },
        desc = "Search/Replace",
      },
    },
  },
  { -- https://github.com/lukas-reineke/indent-blankline.nvim
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  { -- https://github.com/echasnovski/mini.comment
    "echasnovski/mini.comment",
    version = "*",
  },
  { -- https://github.com/echasnovski/mini.diff
    "echasnovski/mini.diff",
    version = "*",
  },
  { -- https://github.com/echasnovski/mini.files
    "echasnovski/mini.files",
    opts = {
      windows = {
        width_focus = 32,
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Explorer",
      },
      {
        "<leader>E",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Explorer (Buffer)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh { content = { filter = new_filter } }
      end

      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require("mini.files").get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)

            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in { close_on_file = close_on_file }
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
            toggle_dotfiles,
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
          map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S", "horizontal", true)
          map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
        end,
      })
    end,
  },
  { -- https://github.com/echasnovski/mini.icons
    "echasnovski/mini.icons",
    version = "*",
  },
  { -- https://github.com/echasnovski/mini.notify
    "echasnovski/mini.notify",
    version = "*",
    opts = {},
  },
  { -- https://github.com/echasnovski/mini.pairs
    "echasnovski/mini.pairs",
    version = "*",
    opts = {},
  },
  { -- https://github.com/echasnovski/mini.statusline
    "echasnovski/mini.statusline",
    version = "*",
    opts = {},
  },
  { -- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { mappings = false },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  { -- https://github.com/ibhagwan/fzf-lua
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader><space>",
        function()
          require("fzf-lua").files()
        end,
        desc = "Files",
      },
      {
        "<leader>,",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Grep",
      },
    },
    opts = {},
  },
}

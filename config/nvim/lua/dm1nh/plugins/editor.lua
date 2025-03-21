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
    opts = {
      indent = { char = "╎" },
      scope = { enabled = false },
    },
  },
  { -- https://github.com/echasnovski/mini.comment
    "echasnovski/mini.comment",
    version = "*",
    opts = {},
  },
  { -- https://github.com/echasnovski/mini.files
    "echasnovski/mini.files",
    opts = {
      windows = {
        width_focus = 32,
        preview = false,
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
      local hidden_by_default = { "node_modules", ".git", "build", "dist", ".build" }
      local show_dotfiles = false
      local filter_show = function()
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".") and not vim.tbl_contains(hidden_by_default, fs_entry.name)
      end

      opts = vim.tbl_deep_extend("force", opts or {}, {
        content = { filter = filter_hide },
      })
      require("mini.files").setup(opts)

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
  { -- https://github.com/echasnovski/mini.pairs
    "echasnovski/mini.pairs",
    version = "*",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
    },
  },
  { -- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { mappings = false },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "Tabs" },
          { "<leader>c", group = "Code" },
          { "<leader>d", group = "Debug" },
          { "<leader>f", group = "Find" },
          { "<leader>g", group = "Git" },
          { "<leader>s", group = "Search" },
          { "<leader>t", group = "Toggle" },
          { "<leader>u", group = "UI" },
          { "<leader>x", group = "Diag/Fix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
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
        },
      },
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
      {
        "<leader>gf",
        function()
          require("fzf-lua").git_files()
        end,
        desc = "Git files",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_status()
        end,
        desc = "Git status",
      },
      {
        "<leader>gc",
        function()
          require("fzf-lua").git_commits()
        end,
        desc = "Git commits (Project)",
      },
      {
        "<leader>gC",
        function()
          require("fzf-lua").git_bcommits()
        end,
        desc = "Git commits (Buffer)",
      },
      {
        "<leader>gb",
        function()
          require("fzf-lua").git_blame()
        end,
        desc = "Git blame",
      },
      {
        "<leader>gB",
        function()
          require("fzf-lua").git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>gt",
        function()
          require("fzf-lua").git_tags()
        end,
        desc = "Git tags",
      },
      {
        "<leader>gs",
        function()
          require("fzf-lua").git_stash()
        end,
        desc = "Git stash",
      },
    },
    opts = {},
  },
}

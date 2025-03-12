return {
  { -- https://github.com/echasnovski/mini.diff
    "echasnovski/mini.diff",
    version = "*",
    opts = {
      view = {
        style = "sign",
        signs = { add = "+", change = "~", delete = "-" },
        -- Priority of used visualization extmarks
        priority = 199,
      },
    },
  },
  { -- https://github.com/echasnovski/mini.icons
    "echasnovski/mini.icons",
    version = "*",
    opts = {},
  },
  { -- https://github.com/echasnovski/mini.notify
    "echasnovski/mini.notify",
    version = "*",
    opts = {},
  },
  { -- https://github.com/echasnovski/mini.statusline
    "echasnovski/mini.statusline",
    version = "*",
    opts = {},
  },
}

return {
  { -- https://github.com/echasnovski/mini.bufremove
    "echasnovski/mini.bufremove",
    version = "*",
    opts = {},
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0)
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>bw",
        function()
          require("mini.bufremove").wipeout(0)
        end,
        desc = "Wipeout buffer",
      },
    },
  },
}

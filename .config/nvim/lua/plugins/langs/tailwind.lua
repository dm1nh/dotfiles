return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}

          -- additional settings for the server, e.g:
          -- tailwindCSS = { includeLanguages = { someLang = "html" } }
          -- can be addeded to the settings table and will be merged with
          -- this defaults for Phoenix projects
          settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "roobert/tailwindcss-colorizer-cmp.nvim" }, -- optional if you still want its logic
    opts = {
      completion = {
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _ = ctx.kind_icon, ctx.kind_hl
                  -- Check if this is a tailwind color via the blink lsp hack
                  local tailwind_color = require("blink.cmp.sources.lsp.hacks.tailwind").get_hex_color(ctx.item)
                  if tailwind_color then
                    return "󱓻 " -- or your preferred icon
                  end
                  return kind_icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local _, kind_hl = ctx.kind_icon, ctx.kind_hl
                  local tailwind_color = require("blink.cmp.sources.lsp.hacks.tailwind").get_hex_color(ctx.item)
                  if tailwind_color then
                    local hl_name = "BlinkCmpTailwindColor" .. tailwind_color:gsub("#", "")
                    if #vim.api.nvim_get_hl(0, { name = hl_name }) == 0 then
                      vim.api.nvim_set_hl(0, hl_name, { fg = tailwind_color })
                    end
                    return hl_name
                  end
                  return kind_hl
                end,
              },
            },
          },
        },
      },
    },
  },
}

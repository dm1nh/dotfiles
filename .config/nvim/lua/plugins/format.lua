return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
      -- Format on save (0.11+ safe)
      format_on_save = function(bufnr)
        -- Disable autoformat for very large files
        if vim.api.nvim_buf_line_count(bufnr) > 5000 then
          return
        end
        return {
          timeout_ms = 2000,
          lsp_fallback = true,
        }
      end,
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { "-i", "2", "-ci" },
        -- },
      },
      -- Better notifications
      notify_on_error = true,
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
}

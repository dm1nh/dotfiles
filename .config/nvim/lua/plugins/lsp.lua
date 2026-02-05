return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        keys = {
          { "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" } },
        },
        opts = {},
      },
      { "j-hui/fidget.nvim", opts = {} },
      "blink.cmp",
    },
    opts = {
      inlayhints = { enabled = false },
      servers = {},
    },
    config = vim.schedule_wrap(function(_, opts)
      local map = vim.keymap.set

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- keymaps
          map("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "LSP Info", buffer = buf })
          map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- inlay hints
          if opts.inlayhints.enabled and client and client.supports_method("textDocument/inlayHint", event.buf) then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end)
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰃤 ",
            [vim.diagnostic.severity.WARN] = "󰉀 ",
            [vim.diagnostic.severity.INFO] = "󰋼 ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      local caps = vim.lsp.protocol.make_client_capabilities()

      -- 🔗 integrate blink.cmp
      local ok, blink = pcall(require, "blink.cmp")
      if ok and blink.get_lsp_capabilities then
        caps = blink.get_lsp_capabilities(caps)
      end

      vim.lsp.config(
        "*",
        vim.tbl_deep_extend("force", {
          capabilities = caps,
        }, opts.servers["*"] or {})
      )

      for server, server_opts in pairs(opts.servers) do
        -- vim.print(server_opts)
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
    end),
  },
}

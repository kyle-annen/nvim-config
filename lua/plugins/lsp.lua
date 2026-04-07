-- LSP: language servers, mason, lightbulb, signature help
return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local on_attach = function(_, _)
        -- Neovim 0.12 provides built-in LSP keybindings
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "cssls",
          "dockerls",
          "eslint",
          "elixirls",
          "ruby_lsp",
          "marksman",
          "terraformls",
          "ts_ls",
        },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },

  {
    "kosayoda/nvim-lightbulb",
    event = "VeryLazy",
    config = function()
      require("nvim-lightbulb").setup({
        autocmd = {
          enabled = true,
          events = { "InsertLeave" },
        },
      })
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup({
        fix_pos = true,
        hint_prefix = "",
      })
    end,
  },
}

-- Editing: autopairs, commenting, toggler, alignment, whitespace cleanup
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "gennaro-tedesco/nvim-commaround",
    event = "VeryLazy",
  },
  {
    "nguyenvukhang/nvim-toggler",
    event = "VeryLazy",
    config = function()
      require("nvim-toggler").setup()
    end,
  },
  {
    "echasnovski/mini.align",
    version = "*",
    event = "VeryLazy",
  },
  {
    "mcauley-penney/tidy.nvim",
    event = "BufWritePre",
    config = function()
      require("tidy").setup()
    end,
  },
  {
    "samjwill/nvim-unception",
    lazy = false,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePost",
    cmd = "ConformInfo",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          ruby = {},
          javascript = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          javascriptreact = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          lua = { "stylua" },
        },
        format_after_save = {
          lsp_fallback = true,
        },
      })
    end,
  },
}

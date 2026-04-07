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
}

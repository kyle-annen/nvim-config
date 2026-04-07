-- Git: fugitive, gitsigns, diffview
return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gvdiffsplit", "Gread", "Gwrite" },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  },
}

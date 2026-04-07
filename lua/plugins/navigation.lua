-- Navigation: telescope, file tree, buffer picker, cheatsheet
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeFocus",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {
    "matbme/JABS.nvim",
    cmd = "JABSOpen",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("jabs").setup({})
    end,
  },

  {
    "sudormrfbin/cheatsheet.nvim",
    cmd = "Cheatsheet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}

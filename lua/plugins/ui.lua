-- UI: theme, statusline, notifications, scrollbar, minimap, smooth scroll
return {
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = true,
      })
    end,
  },

  -- Color highlighter
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
    config = function()
      require("scrollbar").setup()
    end,
  },

  -- Minimap
  {
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("evil_line_lua_line_config")
    end,
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
      vim.notify = require("notify")
    end,
  },

  -- Better UI for input/select
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Breadcrumbs / winbar -- archived, consider dropbar.nvim
  {
    "utilyre/barbecue.nvim",
    event = "BufReadPre",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup()
    end,
  },

  -- Smooth scrolling
  {
    "declancm/cinnamon.nvim",
    event = "VeryLazy",
    config = function()
      require("cinnamon").setup({
        keymaps = {
          basic = true,
          extra = true,
        },
      })
    end,
  },

  -- Command-line completion
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    config = function()
      require("wilder").setup({ modes = { ":", "/", "?" } })
    end,
  },
}

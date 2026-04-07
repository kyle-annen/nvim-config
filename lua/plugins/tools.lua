-- Tools: terminal, REST client, debugger, emoji picker
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end,
    cmd = "ToggleTerm",
  },

  {
    "rest-nvim/rest.nvim",
    enabled = false, -- archived API, needs migration to rewrite
    -- config = function()
    --   require("rest-nvim").setup()
    -- end,
    -- ft = "http",
  },

  {
    "mfussenegger/nvim-dap",
    cmd = { "DapToggleBreakpoint", "DapContinue" },
  },

  {
    "ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
    cmd = { "IconPickerInsert", "IconPickerYank", "IconPickerNormal" },
  },
}

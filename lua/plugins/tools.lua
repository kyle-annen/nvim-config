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
    "mfussenegger/nvim-dap",
    cmd = { "DapToggleBreakpoint", "DapContinue" },
  },

  {
    "stevearc/profile.nvim",
    lazy = false,
    config = function()
      local should_profile = os.getenv("NVIM_PROFILE")
      if should_profile then
        if should_profile:lower():match("^start") then
          require("profile").start("*")
        else
          require("profile").instrument("*")
        end
      end

      local function toggle_profile()
        local prof = require("profile")
        if prof.is_recording() then
          prof.stop()
          vim.ui.input(
            { prompt = "Save profile to:", completion = "file", default = "profile.json" },
            function(filename)
              if filename then
                prof.export(filename)
                vim.notify("Profile saved to " .. filename)
              end
            end
          )
        else
          prof.start("*")
          vim.notify("Profiling started")
        end
      end

      vim.keymap.set("n", "<leader>pp", toggle_profile, { desc = "Toggle profiler" })
    end,
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

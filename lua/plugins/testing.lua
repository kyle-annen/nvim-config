-- Testing: test runner, test navigation
return {
  {
    "klen/nvim-test",
    config = function()
      vim.env.SIMPLECOV = "1"
      require("nvim-test").setup({
        termOpts = {
          direction = "vertical",
          width = 80,
        },
      })
      require("nvim-test.runners.rspec"):setup {
        command = "bundle",
      }
    end,
    cmd = { "TestSuite", "TestFile", "TestEdit", "TestNearest", "TestLast", "TestVisit", "TestInfo" },
  }
}

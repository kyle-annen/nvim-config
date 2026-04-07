-- Testing: nvim-test runner, test navigation
return {
  {
    "klen/nvim-test",
    config = function()
      require("nvim-test").setup()
      require("nvim-test.runners.rspec"):setup {
        command = "bundle",
        args = { "exec", "rspec" },
      }
    end,
    cmd = { "TestSuite", "TestFile", "TestEdit", "TestNearest", "TestLast", "TestVisit", "TestInfo" },
  },
  {
    "davebrace/vim-testnav",
    event = "VeryLazy",
  },
}

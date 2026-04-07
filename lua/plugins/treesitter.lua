-- Treesitter: syntax highlighting, autotag
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'ruby',
          'typescript',
          'tsx',
          'javascript',
          'html',
          'css',
          'scss',
          'json',
          'yaml',
          'lua',
          'bash',
          'dockerfile',
          'markdown',
          'markdown_inline',
          'terraform',
          'elixir',
          'vim',
          'vimdoc',
          'regex',
          'embedded_template',
        },
        sync_install = false,
        highlight = { enable = true },
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}

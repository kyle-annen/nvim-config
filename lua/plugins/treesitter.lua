-- Treesitter: parser installation and syntax highlighting
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- In modern nvim-treesitter, highlighting is built into Neovim.
      -- The plugin just manages parser installation.
      -- Install parsers for the languages we use.
      local ensure_installed = {
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
      }

      local installed = require('nvim-treesitter').get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)

      if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
      end

      -- Neovim only auto-enables treesitter highlights for a few built-in
      -- filetypes (lua, markdown, help). Enable it for everything else.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },

}

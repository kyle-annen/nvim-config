-- silence vim warning
local vim = vim

-- Neovim 0.10+ provides built-in LSP keybindings automatically:
--   K        → hover docs
--   gd       → go to definition
--   gD       → go to declaration
--   gri      → go to implementation
--   grr      → go to references
--   grn      → rename symbol
--   gra      → code action
--   gO       → document symbols
--   <C-s>    → signature help (insert mode)
--   [d / ]d  → prev/next diagnostic
--
-- on_attach is kept as a hook for any future per-server customization
local on_attach = function(client, bufnr)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- define utility function
local has_words_before = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return (vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], true)[1] or ''):sub(cursor[2], cursor[2]):match('%s')
end
--- nvim-cmp configuration
local cmp = require('cmp')
local lspkind = require('lspkind')

--- nvim-cmp use tab to cycle auto completion
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      -- setting up snippet engine
      -- this is for vsnip, if you're using other
      -- snippet engine, please refer to the `nvim-cmp` guide
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    {
      name = 'spell',
      option = {
        keep_all_entries = false,
        enable_in_context = function() return true end,
      }
    },
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      max_width = 50,
      symbol_map = { Copilot = "" }
    })
  },
  -- other settings ...
  mapping = {
    -- confirm with Enter
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- select with Tab
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    -- selet up with Shift-Tab
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  }
})

-- treesitter config (single source of truth — removed duplicate in plugins.lua)
require 'nvim-treesitter.configs'.setup {
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
  highlight = {
    enable = true,
  },
}

-- JABS buffer switcher configurations
require('jabs').setup {}

-- export on_attach and capabilities for use by mason-lspconfig handler
return {
  on_attach = on_attach,
  capabilities = capabilities,
}

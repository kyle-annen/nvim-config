----------------------------------------- leader (must be set before lazy.nvim)
vim.g.mapleader = ' '

----------------------------------------- disable netrw (required by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

----------------------------------------- disable unused providers
vim.g.loaded_perl_provider = 0

----------------------------------------- must be set before colorscheme loads
vim.opt.termguicolors = true

----------------------------------------- shim: suppress client.is_stopped deprecation warning
-- nvim-lspconfig and copilot-cmp use client.is_stopped() (old API); fixed upstream but not yet released.
-- Remove this shim once both plugins call client:is_stopped() instead.
vim.fn.writefile(
  { "[shim] client.is_stopped deprecation suppressed (nvim-lspconfig, copilot-cmp)" },
  vim.fn.stdpath("log") .. "/shims.log",
  "a"
)
local _deprecate = vim.deprecate
vim.deprecate = function(name, ...)
  if name == 'client.is_stopped' then return end
  return _deprecate(name, ...)
end

----------------------------------------- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

----------------------------------------- plugins (lua/plugins/*.lua)
require('lazy').setup('plugins')

----------------------------------------- settings
require('keybindings')
require('editor-settings')


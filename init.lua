----------------------------------------- leader (must be set before lazy.nvim)
vim.g.mapleader = ' '

----------------------------------------- disable netrw (required by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

----------------------------------------- autocommands
require('lsp-format-on-save-autocommand')

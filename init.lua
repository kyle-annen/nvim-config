----------------------------------------- plugins
require('plugins')             -- Plugins managed by Packer, packer config and bootstrap here as well
require('auto-packer-compile') -- autocommand to run :PackerCompile on plugins.lua change

----------------------------------------- settings
require('keybindings')
require('editor-settings')

----------------------------------------- language servers
require('lsp-configs')
require('lsp-format-on-save-autocommand') -- autocommand to format on save

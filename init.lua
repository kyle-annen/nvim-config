----------------------------------------- Plugins
require('plugins')             -- Plugins managed by Packer, packer config and bootstrap here as well
require('auto-packer-compile') -- Autocommand to run :PackerCompile on plugins.lua change

----------------------------------------- Settings
require('keybindings')
require('editor-settings')

----------------------------------------- Language Servers
require('lsp-configs')                    -- Language server configuration
require('lsp-format-on-save-autocommand') -- Autocommand to format on save

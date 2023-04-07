----------------------------------------- Plugins
require('plugins')                        -- Plugins managed by Packer, packer config and bootstrap here as well
require('auto-packer-compile')            -- Autocommand to run :PackerCompile on plugins.lua change

----------------------------------------- Settings
require('keybindings')
require('editor-settings')

----------------------------------------- language servers
require('lsp-configs')
require('lsp-format-on-save-autocommand') -- autocommand to format on save

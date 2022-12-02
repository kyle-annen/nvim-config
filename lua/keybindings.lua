-- ------------------------- helper functions for keybindings -------------------------

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- keymap in normal mode
function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- keymap in interactive mode
function imap(shortcut, command)
  map('i', shortcut, command)
end

-- keymap in visual mode
function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- ------------------------- keybindings ----------------------------------------------
-- set leader as space
vim.g.mapleader = ' '
nmap('<leader>w', '<cmd>write<CR>')
nmap('<leader>q', '<cmd>quit<CR>')

-- jk to exit and save
imap('jk', '<Esc>:w<CR>')
-- Esc to exit and save
imap('<Esc>', '<Esc>:w<CR>')
-- x deletes and saves in normal mode
nmap('x', 'x:w<CR>')

-- remap j and k to move across display lines and not real lines
nmap('k', 'gk')
nmap('gk', 'k')
nmap('j', 'gj')
nmap('gj', 'j')

-- one comment command to rule them all
vmap('<leader>c', '<Plug>ToggleCommaround<CR>')

-- opens JABS buffer picker
nmap('<leader>b', '<cmd>JABSOpen<CR>')

-- copy and paste with ctrl-{c,v}
imap('<c-c>', '"*y :let @+=@*<CR>')
imap('<c-v>', '"+p')

-- telescope
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- nvim tree
nmap('<leader>tt', '<cmd>NvimTreeFocus<CR>')
nmap('<leader>tc', '<cmd>NvimTreeClose<CR>')
nmap('<leader>tr', '<cmd>NvimTreeRefresh<CR>')

-- rest-nvim
nmap('<leader>rr', '<Plug>RestNvim<CR>')
nmap('<leader>rp', '<Plug>RestNvimPreview<CR>')
nmap('<leader>rl', '<Plug>RestNvimLast<CR>')

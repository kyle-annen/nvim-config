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

-- ------------------------- helper functions for keybindings -------------------------
-- set leader as space
vim.g.mapleader = ' '
nmap('<leader>w', '<cmd>write<CR>')
nmap('<leader>q', '<cmd>quit<CR>')
imap('jk', '<Esc>')

-- remap j and k to move across display lines and not real lines
nmap('k', 'gk')
nmap('gk', 'k')
nmap('j', 'gj')
nmap('gj', 'j')

-- copy and paste with ctrl-{c,v}
nmap('<c-c>', '"*y :let @+=@*<CR>')
nmap('<c-v>', '"+p')

-- Git
nmap('<leader>b', '<cmd>Git blame<CR>')

-- telescope
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- nvim tree
nmap('<leader>t', '<cmd>NvimTreeFocus<CR>')
nmap('<leader>tc', '<cmd>NvimTreeClose<CR>')
nmap('<leader>tr', '<cmd>NvimTreeRefresh<CR>')

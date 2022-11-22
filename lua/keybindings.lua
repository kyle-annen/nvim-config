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
vim.g.mapleader = ' '
nmap('<leader>w', '<cmd>write<CR>')
nmap('<leader>q', '<cmd>quit<CR>')
imap('jk', '<Esc>')

-- Git
nmap('<leader>b', '<cmd>Git blame<CR>')

-- telescope
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

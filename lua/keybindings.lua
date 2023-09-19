-- ------------------------- helper functions for keybindings ------------------------
local vim = vim

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- keymap in normal mode
local function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- keymap in interactive mode
local function imap(shortcut, command)
  map('i', shortcut, command)
end

-- keymap in visual mode
local function vmap(shortcut, command)
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

-- dd deletes and saves
nmap('dd', 'dd:w<CR>')

-- remap j and k to move across display lines and not real lines
nmap('k', 'gk')
nmap('gk', 'k')
nmap('j', 'gj')
nmap('gj', 'j')

-- spelling keybindings
-- space s is next misspelled word
nmap('<leader>s', ']s')
nmap('<leader>sc', 'z=')

-- one comment command to rule them all
vmap('<leader>c', '<Plug>ToggleCommaround<CR>')
nmap('<leader>c', '<Plug>ToggleCommaround<CR>')


-- opens JABS buffer picker
nmap('<leader>b', '<cmd>JABSOpen<CR>')

-- copy and paste with ctrl-{c,v}
-- TODO(Kyle): find a better way to do this
-- nmap('<c-c>', '"*y :let @+=@*<CR>')
-- nmap('<c-v>', '"+p')

-- emoji picker
imap("<C-i>", "<cmd>IconPickerInsert<cr>")

-- telescope
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")

-- nvim tree
nmap('<leader>tt', '<cmd>NvimTreeFocus<CR>')
nmap('<leader>tc', '<cmd>NvimTreeClose<CR>')
nmap('<leader>tr', '<cmd>NvimTreeRefresh<CR>')

-- nvim-test
nmap('<leader>ts', '<cmd>TestSuite<CR>')
nmap('<leader>tf', '<cmd>TestFile<CR>')
nmap('<leader>te', '<cmd>TestEdit<CR>')
nmap('<leader>tn', '<cmd>TestNearest<CR>')
nmap('<leader>tl', '<cmd>TestLast<CR>')
nmap('<leader>tv', '<cmd>TestVisit<CR>')
nmap('<leader>ti', '<cmd>TestInfo<CR>')

-- rest-nvim
nmap('<leader>rr', '<Plug>RestNvim<CR>')
nmap('<leader>rp', '<Plug>RestNvimPreview<CR>')
nmap('<leader>rl', '<Plug>RestNvimLast<CR>')

-- toggle-term
nmap('<leader>t', '<cmd>ToggleTerm size=20 dir=git_dir direction=horizontal<CR>')

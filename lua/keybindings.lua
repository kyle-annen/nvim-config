-- ------------------------- helper functions for keybindings ------------------------
local vim = vim

local function map(mode, shortcut, command, desc)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true, desc = desc })
end

local function nmap(shortcut, command, desc) map('n', shortcut, command, desc) end
local function imap(shortcut, command, desc) map('i', shortcut, command, desc) end
local function vmap(shortcut, command, desc) map('v', shortcut, command, desc) end
local function tmap(shortcut, command, desc) map('t', shortcut, command, desc) end

-- ------------------------- keybindings ----------------------------------------------
-- leader is set in init.lua (must be set before lazy.nvim)

tmap('jk', "<C-\\><C-n>",  "Exit terminal insert mode")

nmap('<leader>w', '<cmd>write<CR>',  "Write file")
nmap('<leader>q', '<cmd>quit<CR>',   "Quit")

imap('jk',    '<Esc>:w<CR>', "Exit insert and save")
imap('<Esc>', '<Esc>:w<CR>', "Exit insert and save")

nmap('x',  'x:w<CR>',  "Delete char and save")
nmap('dd', 'dd:w<CR>', "Delete line and save")

-- remap j and k to move across display lines and not real lines
nmap('k',  'gk', "Up (display line)")
nmap('gk', 'k',  "Up (real line)")
nmap('j',  'gj', "Down (display line)")
nmap('gj', 'j',  "Down (real line)")

-- smooth scroll
nmap('<C-j>', "<cmd>lua require('cinnamon').scroll('20j')<CR>", "Scroll down")
nmap('<C-k>', "<cmd>lua require('cinnamon').scroll('20k')<CR>", "Scroll up")
vmap('<C-j>', "<cmd>lua require('cinnamon').scroll('20j')<CR>", "Scroll down")
vmap('<C-k>', "<cmd>lua require('cinnamon').scroll('20k')<CR>", "Scroll up")

-- spelling
nmap('<leader>s',  ']s',  "Next misspelling")
nmap('<leader>sc', 'z=',  "Spelling suggestions")

-- commenting
vmap('<leader>c', '<Plug>ToggleCommaround<CR>', "Toggle comment")
nmap('<leader>c', '<Plug>ToggleCommaround<CR>', "Toggle comment")

-- buffers
nmap('<leader>b', '<cmd>JABSOpen<CR>', "Buffer picker")

-- emoji picker
imap("<C-i>", "<cmd>IconPickerInsert<cr>", "Emoji / icon picker")

-- diffview
--[[ nmap("<leader>dbh", "<cmd>DiffviewFileHistory<cr>",   "Branch file history")
nmap("<leader>dh",  "<cmd>DiffviewFileHistory %<cr>",  "Current file history")
nmap("<leader>do",  "<cmd>DiffviewOpen",               "Open diffview")
nmap("<leader>dc",  "<cmd>DiffviewClose<CR>",          "Close diffview")
nmap("<leader>df",  "<cmd>DiffviewToggleFiles<CR>",    "Toggle file panel")
nmap("<leader>dfr", "<cmd>DiffviewRefresh<CR>",        "Refresh file panel") ]]

-- telescope
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find files")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>",  "Live grep")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>",    "Buffers")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>",  "Help tags")

-- nvim-tree
nmap('<leader>tt', '<cmd>NvimTreeFocus<CR>',   "Tree focus")
nmap('<leader>tc', '<cmd>NvimTreeClose<CR>',   "Tree close")
nmap('<leader>tr', '<cmd>NvimTreeRefresh<CR>', "Tree refresh")

-- toggle-term
nmap('<leader>t', '<cmd>ToggleTerm size=20 dir=git_dir direction=horizontal<CR>', "Toggle terminal")

-- nvim-test
nmap('<leader>ts', '<cmd>TestSuite<CR><cmd>wincmd =<CR>',   "Test suite")
nmap('<leader>tf', '<cmd>TestFile<CR><cmd>wincmd =<CR>',    "Test file")
nmap('<leader>te', '<cmd>TestEdit<CR><cmd>wincmd =<CR>',    "Test edit")
nmap('<leader>tn', '<cmd>TestNearest<CR><cmd>wincmd =<CR>', "Test nearest")
nmap('<leader>tl', '<cmd>TestLast<CR><cmd>wincmd =<CR>',    "Test last")
nmap('<leader>tv', '<cmd>TestVisit<CR><cmd>wincmd =<CR>',   "Test visit")
nmap('<leader>ti', '<cmd>TestInfo<CR><cmd>wincmd =<CR>',    "Test info")

-- undotree
nmap('<leader>u', '<cmd>UndotreeToggle<CR>', "Undo tree")

-- nvim-dbee
nmap('<leader>db', '<cmd>lua require("dbee").open()<CR>', "Database (dbee)")

-- conform.nvim — manual format
nmap('<leader>cf', '<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<CR>', "Format buffer")

-- guard-rspec watcher (native nvim terminal, not toggleterm)
nmap('<leader>tw', '<cmd>rightbelow vsplit | terminal bundle exec guard<CR><cmd>wincmd p<CR>', "Test watch (guard)")

-- todo-comments
nmap('<leader>to', '<cmd>TodoTelescope<CR>',                               "Browse TODOs")
nmap(']t',         '<cmd>lua require("todo-comments").jump_next()<CR>',    "Next TODO")
nmap('[t',         '<cmd>lua require("todo-comments").jump_prev()<CR>',    "Prev TODO")

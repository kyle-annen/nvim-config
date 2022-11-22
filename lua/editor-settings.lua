-------------------------------------- Appearance
-- enable mouse interaction
vim.cmd [[set mouse=a]]
-- set line numbers on
vim.wo.number = true

-- maintain undo history between sessions
vim.cmd([[
set undofile
]])


-------------------------------------- Editing
-- set tabs to 2 spaces
vim.o.tabstop = 2
-- set new line in code block indented 2 spaces
vim.o.shiftwidth = 2
-- ensure tab always 2 spaces
vim.o.smarttab = 2
-- tab in insert mode is spaces
vim.o.expandtab = true
-- ignore case in search
vim.o.ignorecase = true
-- don't ingnore capital letters in search query
vim.o.smartcase = true

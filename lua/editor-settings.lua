local vim = vim
-------------------------------------- Appearance
-- enable mouse interaction
vim.cmd [[set mouse=a]]

-- set line numbers
vim.wo.number = true

-- set 86 character limit color
vim.cmd [[set colorcolumn=85]]
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = LightGrey })
vim.api.nvim_set_hl(0, "Normal", { ctermfg = White, ctermbg = Black })

-- maintain undo history between sessions
vim.cmd([[ set undofile ]])

-- set 24-bit color, needed by nvim-notify
vim.notify = require('notify')

vim.opt.list = true
vim.opt.termguicolors = true
vim.opt.listchars:append "eol:↴"
vim.opt.scrolloff = 5

-- set colorscheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])


-------------------------------------- Editing
-- set tabs to 2 spaces
vim.o.tabstop = 2

-- set new line in code block indented 2 spaces
vim.o.shiftwidth = 2

-- ensure tab is smart
vim.o.smarttab = true

-- tab in insert mode is spaces
vim.o.expandtab = true

-- ignore case in search
vim.o.ignorecase = true

-- don't ingnore capital letters in search query
vim.o.smartcase = true

-- use builin spellchecking
vim.opt.spell = true;
vim.opt.spelllang = 'en_us'

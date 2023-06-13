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

-- set indent-blankline highlight values
vim.opt.list = true
vim.opt.termguicolors = true
vim.opt.listchars:append "eol:↴"
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- set colorscheme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])


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

-- use builin spellchecking
vim.opt.spelllang = 'en_us'

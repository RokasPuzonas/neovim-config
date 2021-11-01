local opt = require 'utils.opt'
local o, wo, bo = vim.o, vim.wo, vim.bo
local cmd = vim.cmd

cmd [[syntax on]]
cmd [[filetype plugin on]]


local buffer = { o, bo }
local window = { o, wo }

-- List of possible completion options
opt('completeopt', 'menu,menuone,noselect')

-- Pseudo transparent popup window
opt('pumblend', 15)
cmd [[highlight PmenuSel blend=0]]

-- Don't wrap text to next line if there isin't enough space
opt('wrap', false)

-- Highlight current line
opt('cursorline', true, window)

-- Store less in shada files
opt('shada', [['20,<50,s10,h,/100]])

-- Show current mode that you are in
opt('showmode', true)

-- Keep non-visible files open
opt('hidden', true)

-- Skip redrawing window while executing macro
opt('lazyredraw', true)

-- Always use system clipboard
opt('clipboard', 'unnamedplus')

-- Amount of time after which while typing mapping will be canceled
opt('timeoutlen', 300)

-- Load external project specific configs
opt('exrc', true)
opt('secure', true)

-- How whitespace characters should be displayed
opt('listchars', [[space:.,eol:$,tab:>-]])

-- If possible use 24 Bit Colors
if vim.fn.has('termguicolors') == 1 then
  opt('termguicolors', true)
end

-- Better Searching (Incremental searching, live replacing)
opt('hlsearch', false)
opt('incsearch', true)
opt('inccommand', 'nosplit')

-- Always keep at least 8 blank lines below the last line
opt('scrolloff', 8)

-- Draw a line on the 80 character mark for reference
-- My laptop screen is pretty small so it's 80 so that 2 splits can fit
-- If you have a wider monitor go ahead and use 100 or 120.
opt('colorcolumn', '80')

-- Break lines
-- opt('textwidth', 80)

-- Display relative and absolute line numbers
opt('number', true, window)
opt('relativenumber', true, window)

-- Recovery
opt('undofile', true, buffer)

-- Mouse support
opt('mouse', 'nivh')

-- Auto sign column
opt('signcolumn', 'auto:1', window)

-- Disable those annoying DINGS when you pressing something too much
opt('errorbells', false)

-- Always use system clipboard
opt('clipboard', 'unnamedplus')

-- Folding options
opt('foldmethod', 'indent')
opt('foldlevelstart', 99)

-- Identation/Tab settings
local tab_size = 2
opt('expandtab', false, buffer)
opt('smartindent', true, buffer)
opt('shiftwidth', tab_size, buffer)
opt('tabstop', tab_size, buffer)
opt('softtabstop', tab_size, buffer)

-- Place splits below and to the right by default
opt('splitbelow', true)
opt('splitright', true)


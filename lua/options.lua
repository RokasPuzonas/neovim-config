local opt = require 'utils.opt'
local autocmd = require 'utils.autocmd'
local o, wo, bo = vim.o, vim.wo, vim.bo
local cmd = vim.cmd

cmd [[syntax on]]
cmd [[filetype plugin on]]


local buffer = { o, bo }
local window = { o, wo }

-- Enable auto reload of changed files
opt('autoread', true)
autocmd("auto-reload", {
	[[FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif]],
	[[FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]
}, true)

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

-- How whitespace characters should be displayed
opt('listchars', [[space:.,eol:$,tab:>-]])

-- If possible use 24 Bit Colors
if vim.fn.has('termguicolors') == 1 then
  opt('termguicolors', true)
end

-- Better Searching (Incremental searching, live replacing)
opt('ignorecase', true)
opt('smartcase', true)
opt('hlsearch', false)
opt('incsearch', true)
opt('inccommand', 'nosplit')

-- Always keep at least 8 blank lines below the last line
opt('scrolloff', 8)

opt('colorcolumn', '110')

-- Break lines
-- opt('textwidth', 80)

-- Display relative and absolute line numbers
opt('number', true, window)
opt('relativenumber', true, window)

-- Recovery
opt('undofile', true, buffer)

-- Mouse support
opt('mouse', 'nivh')
opt('mousemodel', 'extend')

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
local tab_size = 4
opt('expandtab', false, buffer)
opt('smartindent', true, buffer)
opt('shiftwidth', tab_size, buffer)
opt('tabstop', tab_size, buffer)
opt('softtabstop', tab_size, buffer)
opt('cinkeys', '0{,0},0),0],:,!^F,o,O,e')
opt('cinoptions', 's,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,N0,E0,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,k0,m0,j0,J0,)20,*70,#1,P0')

-- Place splits below and to the right by default
opt('splitbelow', true)
opt('splitright', true)

-- Remove cmdline when not used
opt('cmdheight', 0)

-- Scale neovide a bit
if vim.g.neovide then
	vim.g.neovide_scale_factor = 0.75
	vim.g.neovide_hide_mouse_when_typing = true
end

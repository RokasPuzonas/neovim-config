local map = require 'utils.map'

local silent = {silent = true}

-- Disable Ex mode
map('n', 'Q', '<nop>')

-- Save file
map('n', '<C-s>', ':w<cr>')

-- Window movement
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Resize windows
map('n', '<M-j>', ':resize -2<cr>', silent)
map('n', '<M-k>', ':resize +2<cr>', silent)
map('n', '<M-h>', ':vertical resize -2<cr>', silent)
map('n', '<M-l>', ':vertical resize +2<cr>', silent)

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Better movement between tabs
map('n', '<C-Left>', ':tabprevious<cr>', silent)
map('n', '<C-Right>', ':tabnext<cr>', silent)

-- Move lines up or down
map('n', '<A-j>', ':m .+1<CR>==', silent)
map('n', '<A-j>', ':m .+1<CR>==', silent)
map('n', '<A-k>', ':m .-2<CR>==', silent)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', silent)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', silent)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", silent)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", silent)

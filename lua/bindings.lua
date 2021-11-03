local map = require 'utils.map'

local silent = {silent = true}

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


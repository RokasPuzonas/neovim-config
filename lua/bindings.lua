local map = require 'utils.map'

local silent = {silent = true}

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

-- Go to tab by number
map('n', '<leader>1', '1gt')
map('n','<leader>2', '2gt')
map('n','<leader>3', '3gt')
map('n','<leader>4', '4gt')
map('n','<leader>5', '5gt')
map('n','<leader>6', '6gt')
map('n','<leader>7', '7gt')
map('n','<leader>8', '8gt')
map('n','<leader>9', '9gt')
map('n','<leader>0', ':tablast<cr>')


local map = require 'utils.map'

local silent = {silent = true}

-- Window movement
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')


-- Toggle whitespace characters
map('n', '<leader>tw', ':setlocal list!<cr>')


-- Toggle numbers and sign column
map('n', '<leader>tn', ':setlocal relativenumber!<cr>:setlocal number!<cr>')


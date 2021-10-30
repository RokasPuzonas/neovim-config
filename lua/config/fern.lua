local map = require 'utils.map'
local M = {}

vim.g['fern#hide_cursor'] = true

map('n', '<leader>e', ':Fern . -drawer -reveal=% -toggle<cr>', {silent = true})

return M

local map = require 'utils.map'

map('n', '<leader>rc', ':Restart<cr>', {silent = true})

vim.cmd [[command! PackerRestart exe 'Restart' | exe 'PackerCompile' | exe 'PackerSync']]


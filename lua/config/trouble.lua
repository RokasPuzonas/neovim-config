local map = require 'utils.map'

require('trouble').setup()

local silent = {silent = true}

map('n', '<leader>q', ':TroubleToggle document_diagnostics<cr>', silent)


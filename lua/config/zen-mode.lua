local map = require 'utils.map'

require("zen-mode").setup{
	window = {
		options = {
			number = false,
			relativenumber = false,
			cursorline = false
		}
	}
}

map('n', '<leader>z', ':ZenMode<cr>')

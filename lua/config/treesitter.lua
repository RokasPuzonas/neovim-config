return {
	'nvim-treesitter/nvim-treesitter',
	run = function() require('nvim-treesitter.install').update{ with_sync = true } end,
	config = function ()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup{
			highlight = { enable = true },
			auto_install = true
		}
	end
}

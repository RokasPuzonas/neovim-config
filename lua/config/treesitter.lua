return {
	'nvim-treesitter/nvim-treesitter',
	run = function() require('nvim-treesitter.install').update{ with_sync = true } end,
	config = function ()
		local treesitter = require("nvim-treesitter.configs")
		if vim.fn.has("win32") then
			require('nvim-treesitter.install').compilers = { "clang" }
		end

		treesitter.setup{
			highlight = { enable = true },
			auto_install = true
		}
	end
}

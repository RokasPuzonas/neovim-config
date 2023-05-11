return {
	'f-person/git-blame.nvim',
	config = function ()
		local map = require 'utils.map'
		local silent = {silent = true}

		map('n', '<leader>gm', ":GitBlameCopySHA<CR>", silent)
		map('n', '<leader>gj', ":GitBlameOpenCommitURL<CR>", silent)
		map('n', '<leader>gu', ":GitBlameToggle<CR>", silent)

		vim.g["gitblame_enabled"] = 0
	end
}

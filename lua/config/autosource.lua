return {
	'jenterkin/vim-autosource',
	config = function()
		local data = vim.fn.stdpath("data")
		vim.g.autosource_hashdir = data .. '/vim-autosource/hashes'
	end
}

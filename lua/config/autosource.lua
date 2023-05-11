return {
	'jenterkin/vim-autosource',
	config = function()
		local user = os.getenv("USER")
		vim.g.autosource_hashdir = '/home/'..user..'/.cache/vim-autosource/hashes'
	end
}

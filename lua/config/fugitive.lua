return {
	'tpope/vim-fugitive',
	config = function ()
		-- TODO: Add most commonly used fugitive bindings
		require("legendary").keymaps{
			{"<leader>gg", ":G<cr>", description = "Open fugitive", opts = {silent = true}}
		}
	end
}

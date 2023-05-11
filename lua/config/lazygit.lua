return {
	'kdheepak/lazygit.nvim',
	config = function ()
		require("legendary").keymaps{
			{"<leader>gg", ":LazyGit<cr>", description = "Open lazygit", opts = {silent = true}}
		}
	end
}

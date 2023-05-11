return {
	'mrjones2014/legendary.nvim',
	requires = 'stevearc/dressing.nvim',
	config = function()
		require("legendary").setup{
			include_legendary_cmds = false,
			keymaps = {
				{"<leader>l", ":Legendary<cr>", description = "Open this help menu"}
			}
		}
	end
}

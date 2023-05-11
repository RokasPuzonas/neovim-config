return {
	'akinsho/toggleterm.nvim',
	tag = '*',
	config = function()
		require('toggleterm').setup()

		require("legendary").keymap{
			"<leader>t", ":ToggleTerm<CR>", description = "Toggle terminal", opts = { silent = true }
		}
	end
}

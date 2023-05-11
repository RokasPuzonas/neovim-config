return {
	'akinsho/toggleterm.nvim',
	tag = '*',
	config = function()
		require('toggleterm').setup()

		vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
	end
}

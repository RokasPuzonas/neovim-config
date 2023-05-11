return {
	'ggandor/leap.nvim',
	config = function()
		local silent = {silent=true}
		vim.keymap.set("n", "s", "<Plug>(leap-forward-to)", silent)
		vim.keymap.set("n", "S", "<Plug>(leap-backward-to)", silent)
	end
}

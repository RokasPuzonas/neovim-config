return {
	'kyazdani42/nvim-tree.lua',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function ()
		require("nvim-tree").setup{
			git = {
				enable = false
			},
			renderer = {
				group_empty = true,
			},
		}

		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {silent = true})
		vim.keymap.set("n", "<leader>f", ":NvimTreeFindFileToggle<CR>", {silent = true})
	end
}

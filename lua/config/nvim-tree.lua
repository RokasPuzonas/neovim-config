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

		require("legendary").keymaps{
			{"<leader>e", ":NvimTreeToggle<CR>", description = "Toggle file tree", {silent = true}},
			{"<leader>f", ":NvimTreeFindFileToggle<CR>", description = "Show file in tree", {silent = true}}
		}
	end
}

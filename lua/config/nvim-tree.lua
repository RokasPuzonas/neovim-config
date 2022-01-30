local map = require("utils.map")

require("nvim-tree").setup{
	git = {
		enable = false
	}
}

map("n", "<leader>e", ":NvimTreeToggle<CR>", {silent = true})

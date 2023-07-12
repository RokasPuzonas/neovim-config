return {
	"SmiteshP/nvim-navbuddy",
	requires = {
		"neovim/nvim-lspconfig",
		"SmiteshP/nvim-navic",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim"
	},

	config = function()
		local navbuddy = require("nvim-navbuddy")

		require("legendary").keymaps{
			{"<leader>o", ":Navbuddy<CR>", description="Navbuddy"}
		}

		navbuddy.setup {
			window = {
				border = "rounded",
				size = "60%",
				position = "50%",
				sections = {
					left  = { size = "20%" },
					mid   = { size = "40%" },
					right = { preview = "leaf" }
				},
			},
			node_markers = { enabled = true },
			use_default_mappings = true,
			lsp = { auto_attach = true }
		}
	end
}

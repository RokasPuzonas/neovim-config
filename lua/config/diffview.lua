return {
	"sindrets/diffview.nvim",
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		require("diffview").setup{
			enhanced_diff_hl = true
		}
		require("legendary").command{
			":DiffviewOpen", description = "Open diff view"
		}
	end
}

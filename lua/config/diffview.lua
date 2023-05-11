return {
	"sindrets/diffview.nvim",
	requires = 'nvim-lua/plenary.nvim',
	config = function()
		require("legendary").command{
			":DiffviewOpen", description = "Open diff view"
		}
	end
}

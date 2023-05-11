return {
	"folke/todo-comments.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup { signs = false }

		require("legendary").command{
			":TodoTelescope", description = "Show TODO's in telescope"
		}
	end
}

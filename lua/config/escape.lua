return {
	"m-gail/escape.nvim",
	config = function()
		local escape = require("escape").escape

		require("legendary").keymaps{
			{"<leader>e", escape, description="Escape quotes", mode={"v"}, opts={noremap=true,silent = true}}
		}
	end
}

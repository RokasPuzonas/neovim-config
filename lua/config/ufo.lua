return {
	"kevinhwang91/nvim-ufo",
	requires = {"kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter"},
	config = function ()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return {"treesitter", "indent"}
			end
		})
		vim.highlight.link("UfoFoldedBg", "ColorColumn")
	end
}

return {
	"kevinhwang91/nvim-ufo",
	requires = {"kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter"},
	config = function ()
		local default = {"treesitter", "indent"}
		local filetypes = { c = {'indent'} }

		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return filetypes[filetype] or default
			end
		})
		vim.api.nvim_set_hl(0, "UfoFoldedBg", { link = "ColorColumn" })
	end
}

return {
	"vim-scripts/DoxygenToolkit.vim",
	config = function()
		vim.g.DoxygenToolkit_startCommentTag = "/// "
		vim.g.DoxygenToolkit_interCommentTag = "/// "
		vim.g.DoxygenToolkit_endCommentTag = ""
		vim.g.DoxygenToolkit_startCommentBlock = "// "
		vim.g.DoxygenToolkit_interCommentBlock = "// "
		vim.g.DoxygenToolkit_endCommentBlock = ""
	end
}

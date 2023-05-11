return {
	'folke/trouble.nvim',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function ()
		local map = require 'utils.map'

		require('trouble').setup()

		local silent = {silent = true}

		map('n', '<leader>qq', ':TroubleToggle document_diagnostics<cr>', silent)
		map('n', '<leader>qf', ':TroubleToggle workspace_diagnostics<cr>', silent)
		map('n', '<leader>rf', ':TroubleToggle lsp_references<cr>', silent)
	end
}

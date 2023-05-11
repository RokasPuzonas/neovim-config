return {
	'folke/trouble.nvim',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function ()
		require('trouble').setup()

		local silent = {silent = true}

		require("legendary").keymaps{
			{'<leader>qq', ':TroubleToggle document_diagnostics<cr>', description="Toggle file diagnostics", opts=silent},
			{'<leader>qf', ':TroubleToggle workspace_diagnostics<cr>', description="Toggle workspace diagnostics", opts=silent},
			{'gr', ':TroubleToggle lsp_references<cr>', description="Show references in trouble", opts=silent},
		}
	end
}

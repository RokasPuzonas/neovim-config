return {
	'fedepujol/move.nvim',
	config = function()
		local opts = { noremap = true, silent = true }

		require("legendary").keymaps{
			{mode='v', '<S-j>', ':MoveBlock(1)<CR>', description = "Move block up", opts=opts},
			{mode='v', '<S-k>', ':MoveBlock(-1)<CR>', description = "Move block down", opts=opts},
		}
	end
}

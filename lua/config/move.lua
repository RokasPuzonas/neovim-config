return {
	'fedepujol/move.nvim',
	config = function()
		local opts = { noremap = true, silent = true }
		-- Normal-mode commands
		-- vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
		-- vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
		-- vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
		-- vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)

		-- Visual-mode commands
		vim.keymap.set('v', '<S-j>', ':MoveBlock(1)<CR>', opts)
		vim.keymap.set('v', '<S-k>', ':MoveBlock(-1)<CR>', opts)
		vim.keymap.set('v', '<S-h>', ':MoveHBlock(-1)<CR>', opts)
		vim.keymap.set('v', '<S-l>', ':MoveHBlock(1)<CR>', opts)
	end
}

return {
	'akinsho/git-conflict.nvim',
	tag = "*",
	config = function()
		require('git-conflict').setup{
			default_mappings = false
		}


		require("legendary").keymaps{
			{
				itemgroup = "git-conflict",
				description = "Git conflict",
				icon = "",
				keymaps = {
					{ 'co', '<Plug>(git-conflict-ours)', description = "choose ours" },
					{ 'ct', '<Plug>(git-conflict-theirs)', description = "choose theirs" },
					{ 'cb', '<Plug>(git-conflict-both)', description = "choose both" },
					{ 'c0', '<Plug>(git-conflict-none)', description = "choose none" },
					{ ']x', '<Plug>(git-conflict-prev-conflict)', description = "move to previous conflict" },
					{ '[x', '<Plug>(git-conflict-next-conflict)', description = "move to next conflict" },
				}
			}
		}
	end
}

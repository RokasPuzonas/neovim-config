return {
	'ggandor/leap.nvim',
	config = function()
		local silent = {silent=true}

		require("legendary").keymaps{
			{"s", "<Plug>(leap-forward-to)", description="Leap forward", opts=silent},
			{"S", "<Plug>(leap-backward-to)", description="Leap backward", opts=silent}
		}

	end
}

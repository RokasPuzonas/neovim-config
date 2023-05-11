return {
	'mrjones2014/legendary.nvim',
	config = function()
		vim.keymap.set("n", "<leader>l", ":Legendary<cr>", {silent = true})

		require("legendary").setup{
			include_legendary_cmds = false,
			commands = {
				{ ":TodoTelescope", description = "Show TODO's in telescope" }
			}
		}
	end
}

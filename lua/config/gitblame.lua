return {
	'f-person/git-blame.nvim',
	config = function ()
		local silent = {silent = true}

		require("legendary").keymaps{
			{
				itemgroup = "gitblame",
				description = "Git blame",
				icon = "",
				keymaps = {
					{"<leader>gm", ":GitBlameCopySHA<CR>", description = "Copy commit hash", opts = silent},
					{"<leader>gj", ":GitBlameOpenCommit<CR>", description = "Open commit", opts = silent},
					{"<leader>gu", ":GitBlameToggle<CR>", description = "Toggle git blame", opts = silent},
				}
			}
		}

		vim.g["gitblame_enabled"] = 0
		vim.g["gitblame_date_format"] = "%r"
	end
}

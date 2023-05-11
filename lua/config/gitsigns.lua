return {
	'lewis6991/gitsigns.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = function ()
		local gitsigns = require 'gitsigns'

		gitsigns.setup{
			on_attach = function(bufnr)
				local function keymap_n(key, command, description, opts)
					opts = vim.tbl_extend('force', {noremap = true, silent = true, buffer=bufnr}, opts or {})
					return {key, command, description=description, opts=opts}
				end
				local function keymap_vn(key, command, description, opts)
					opts = vim.tbl_extend('force', {noremap = true, silent = true, buffer=bufnr}, opts or {})
					return {key, command, mode={"v", "n"}, description=description, opts=opts}
				end

				require("legendary").keymaps{
					{
						itemgroup = "githunks",
						description = "Git hunks",
						icon = "",
						keymaps = {
							keymap_n(']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", "Jump to next hunk", {expr=true}),
							keymap_n('[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", "Jump to prev hunk", {expr=true}),

							keymap_vn("<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk"),
							keymap_vn("<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk"),
							keymap_n("<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", "Stage buffer"),
							keymap_n("<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk"),
							keymap_n("<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", "Reset buffer"),
							keymap_n("<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk"),
							keymap_n('<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', "Toggle deleted"),

							{'ih', {o=':<C-U>Gitsigns select_hunk<CR>', x=':<C-U>Gitsigns select_hunk<CR>'},  description="Select hunk" }
						}
					}
				}
			end
		}
	end
}

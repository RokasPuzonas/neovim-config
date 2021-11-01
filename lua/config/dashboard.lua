local autocmd = require 'utils.autocmd'

vim.g.dashboard_default_executive = 'telescope'

-- local function split(text)
-- 	local parts = {}
-- 	for part in text:gmatch("[^\n]+") do
-- 		table.insert(parts, part)
-- 	end
-- 	return parts
-- end
-- vim.g.dashboard_custom_header = split(vim.fn.system("figlet -m 2 -f slant Neovim"))

-- vim.g.dashboard_custom_header = {
-- 	' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
-- 	' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
-- 	' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
-- 	' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
-- 	' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
-- 	' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
-- }

vim.g.dashboard_custom_header = {
 [[    _   __                   _          ]],
 [[   / | / /___   ____ _   __ (_)____ ___ ]],
 [[  /  |/ // _ \ / __ \ | / // // __ `__ \]],
 [[ / /|  //  __// /_/ / |/ // // / / / / /]],
 [[/_/ |_/ \___/ \____/|___//_//_/ /_/ /_/ ]],
}

autocmd('dashboard-commands', {
	[[FileType dashboard nmap <buffer> <leader>ss :<C-u>SessionSave<cr>]],
	[[FileType dashboard nmap <buffer> <leader>sl :<C-u>SessionLoad<CR>]],
	[[FileType dashboard nnoremap <buffer> <silent> <leader>fh :DashboardFindHistory<cr>]],
	[[FileType dashboard nnoremap <buffer> <silent> <leader>ff :DashboardFindFile<cr>]],
	[[FileType dashboard nnoremap <buffer> <silent> <leader>tc :DashboardChangeColorscheme<cr>]],
	[[FileType dashboard nnoremap <buffer> <silent> <leader>fa :DashboardFindWord<cr>]],
	[[FileType dashboard nnoremap <buffer> <silent> <leader>fb :DashboardJumpMark<cr>]],
	[[FileType dashboard nnoremap <buffer> <silent> <leader>cn :DashboardNewFile<cr>]],
}, true)


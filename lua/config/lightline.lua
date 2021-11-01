local opt = require 'utils.opt'

opt('showmode', false)

vim.cmd [[
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
]]

vim.g.lightline = {
	colorscheme = vim.g.colors_name,
	active = {
		left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename' } }
	},
	component_function = {
		gitbranch = 'FugitiveHead',
		filename = 'LightlineFilename'
	}
}


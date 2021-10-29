local opt = require 'utils.opt'
local cmd = vim.cmd

opt('background', 'dark')
cmd [[colorscheme gruvbox]]

-- Background transparency
cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
cmd [[highlight Folded guibg=NONE ctermbg=NONE]]


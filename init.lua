local opt = require 'utils.opt'
local g = vim.g
local cmd = vim.cmd

-- Allow loading */init.lua files
package.path = "./?/init.lua;"..package.path

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'matchit',
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
}

for _, name in ipairs(disabled_built_ins) do
  g['loaded_' .. name] = 1
end

require("plugins")
require("options")
require("bindings")
require("pludin-dev")

-- Misc features
require("highlight-yank")

-- Background transparency
-- cmd [[autocmd ColorScheme * highlight Normal ctermbg=none guibg=none]]
-- cmd [[autocmd ColorScheme * highlight Folded ctermbg=none guibg=none]]
-- cmd [[autocmd ColorScheme * highlight SignColumn ctermbg=none guibg=none]]
-- cmd [[autocmd ColorScheme * highlight VertSplit ctermbg=none guibg=none]]
-- cmd [[autocmd ColorScheme * highlight StatusLineNC ctermbg=none guibg=none]]
-- cmd [[autocmd ColorScheme * highlight CursorLineNr ctermbg=none guibg=none]]

-- THEME_BEGIN
cmd("colorscheme srcery")
-- THEME_END

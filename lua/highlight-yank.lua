local autocmd = require 'utils.autocmd'

autocmd("highlight_yank", {
	[[TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=150})]]
}, true)

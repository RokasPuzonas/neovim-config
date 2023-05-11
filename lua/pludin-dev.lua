local map = require 'utils.map'

map("n", "<leader><leader>x", ":w<cr>:source %<cr>")

function P(...)
	print(vim.inspect(...))
end

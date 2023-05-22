
vim.keymap.set("n", "<leader><leader>x", ":w<cr>:source %<cr>", { silent = true })

function P(...)
	print(vim.inspect(...))
end

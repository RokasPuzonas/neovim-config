local map = require 'utils.map'

local silent = {silent = true}

-- Disable Ex mode
map('n', 'Q', '<nop>')

-- Save file
map('n', '<C-s>', ':w<cr>')

-- Paste from register and not replace it
-- map('x', '<leader>p', '"_dP')

-- Window movement
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Resize windows
map('n', '<M-j>', ':resize -2<cr>', silent)
map('n', '<M-k>', ':resize +2<cr>', silent)
map('n', '<M-h>', ':vertical resize -2<cr>', silent)
map('n', '<M-l>', ':vertical resize +2<cr>', silent)

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Better movement between tabs
map('n', '<C-Left>', ':tabprevious<cr>', silent)
map('n', '<C-Right>', ':tabnext<cr>', silent)

-- Move lines up or down
map('n', '<A-j>', ':m .+1<CR>==', silent)
map('n', '<A-j>', ':m .+1<CR>==', silent)
map('n', '<A-k>', ':m .-2<CR>==', silent)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", silent)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", silent)

-- Move between windows easier in terminal windows
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Add abbreviation for != => ~= in lua files
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("MyTermOpen", { clear = true }),
	pattern = "*.lua",
	callback = function()
		vim.api.nvim_cmd({ cmd = "abb", args = {"<buffer>", "!=", "~="}}, {})
	end
})

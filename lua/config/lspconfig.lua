local lspconfig = require('lspconfig')
local M = {}

-- debounce_text_changes = delay, between changing something and lsp updating
M.flags = { debounce_text_changes = 150 }

M.default_settings = {
	Lua = {
		runtime = {
			-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			version = 'LuaJIT',
			-- Setup your lua path
			path = vim.split(package.path, ';')
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = {'vim', 'packer_plugins'}
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true)
		},
		telemetry = { enable = false }
	}
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
  -- Mappings.
  local opts = { noremap = true, silent = true }

  local function buf_set_keymap(mode, lhs, rhs) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

	-- " auto-format
	-- autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
	-- autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
	-- autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
if packer_plugins['cmp-nvim-lsp'] and packer_plugins['cmp-nvim-lsp'].loaded then
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local function on_init(initialize_params, config)
	-- print(vim.inspect(capabilities))
	-- print(vim.inspect(config))
end

-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local function getSumnekoPaths()
	USER = vim.fn.expand('$USER')

	if vim.fn.has("mac") == 1 then
		local sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
		local sumneko_binary = "/Users/" .. USER .. "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
		return sumneko_root_path, sumneko_binary
	elseif vim.fn.has("unix") == 1 then
		local sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
		local sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
		return sumneko_root_path, sumneko_binary
	end
end

local function setupLuaServer()
	local sumneko_root_path, sumneko_binary = getSumnekoPaths()

	if not sumneko_root_path then
		print("Unsupported system for sumneko")
		return
	end

	lspconfig.sumneko_lua.setup {
		cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
		filetypes = {"lua"},
		capabilities = capabilities,
		on_init = on_init,
    flags = M.flags,
		settings = M.default_settings
	}
end

setupLuaServer()

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, name in ipairs(servers) do
  lspconfig[name].setup {
    on_attach = on_attach,
		capabilities = capabilities,
		on_init = on_init,
    flags = M.flags,
		settings = M.default_settings
  }
end

return M


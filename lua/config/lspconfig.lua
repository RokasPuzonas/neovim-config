local M = {}

-- debounce_text_changes = delay, between changing something and lsp updating
M.flags = { debounce_text_changes = 150 }

local general_settings = { }
M.server_init_options = {
	efm = {
		documentFormatting = true
	}
}

M.server_settings = {
	efm = {
		rootMarkers = {".git/"},
		languages = {
			lua = {
				{ formatCommand = "lua-format -i", formatStdin = true }
			}
		},
	},
	jsonls = {
		json = {
			schemas = {
				{
					fileMatch = {"package.json"},
					url = "https://json.schemastore.org/package.json"
				},
				{
					fileMatch = {"tsconfig*.json"},
					url = "https://json.schemastore.org/tsconfig.json"
				},
			}
		}
	},

	-- "Lua.runtime.version": "LuaJIT",
	-- "Lua.workspace.library": ["${3rd}/love2d/library"],
	-- "Lua.workspace.checkThirdParty": false,
	-- "Lua.diagnostics.disable": ["undefined-field"]
	sumneko_lua = {
		Lua = {
			-- runtime = {
			-- 	version = "LuaJIT"
			-- },
			workspace = {
				checkThirdParty = false,
			-- 	library = {"${3rd}/love2d/library"}
			},
			telemetry = { enable = false }

		-- }
		-- Lua = {
		-- 	runtime = {
		-- 		-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
		-- 		version = 'LuaJIT',
		-- 		-- Setup your lua path
		-- 		path = vim.split(package.path, ';')
		-- 	},
		-- 	diagnostics = {
		-- 		-- Get the language server to recognize the `vim` global
		-- 		globals = {'vim', 'packer_plugins'}
		-- 	},
		-- 	workspace = {
		-- 		-- Make the server aware of Neovim runtime files
		-- 		library = vim.api.nvim_get_runtime_file("", true)
		-- 	},
		}
	},

	rust_analyzer = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy"
			}
		}
	}
}

-- Apply general settings for each server
for _, settings in ipairs(M.server_settings) do
	M.server_settings = vim.tbl_deep_extend("keep", settings, general_settings)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
  -- Mappings.
  local opts = { noremap = true, silent = true, buffer = bufnr}

  -- local function keymap(mode, lhs, rhs) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	require("legendary").keymaps{
		{
			itemgroup = "lsp",
			description = "LSP",
			keymaps = {
				{'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', description = "Jump to definition", opts=opts},
				{'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', description = "Jump to declaration", opts=opts},
				{'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', description = "Jump to implementation", opts=opts},
				{'K', '<cmd>lua vim.lsp.buf.hover()<CR>', description = "Show info", opts=opts},
				{'<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', description = "Rename symbol"},
				{'<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', description = "Show code actions"},
				{'<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', description = "Open float"}
			}
		}
	}

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions

	-- Conflicts with movement between panes
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

	-- " auto-format
	-- autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
	-- autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
	-- autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
end

function M.get_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	if packer_plugins['cmp-nvim-lsp'] and packer_plugins['cmp-nvim-lsp'].loaded then
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
	end

	return capabilities
end

function M.on_init(initialize_params, config)
	-- print("lsp init")

	-- TODO: Load settings from ".lspconfig.json" for each projects settings
	-- and merge them with the defaults
	-- https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings
end

function M.get_server_settings(name)
	return M.server_settings[name]
end

function M.get_server_init_options(name)
	return M.server_init_options[name]
end

---@diagnostic disable-next-line: empty-block
if packer_plugins['nvim-lsp-installer'] and packer_plugins['nvim-lsp-installer'].loaded then
	-- local lspconfig = require('lspconfig')
	-- TODO: Manually do "server:setup{}" if lspinstaller is not loaded
end

return M

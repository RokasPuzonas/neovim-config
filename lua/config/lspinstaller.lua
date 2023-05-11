local lspconfig_config = require('config.lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

-- local autoinstall_servers = {"sumneko_lua", "efm"}
local autoinstall_servers = {"sumneko_lua"}
for _, name in ipairs(autoinstall_servers) do
	local ok, server = lsp_installer_servers.get_server(name)
	if ok and not server:is_installed() then
		server:install()
	end
end

local capabilities = lspconfig_config.get_capabilities()

for _, server in ipairs(lsp_installer.get_installed_servers()) do
	local opts = {
		root_dir = function()
			return vim.fn.getcwd()
		end,
		init_options = lspconfig_config.get_server_init_options(server.name),
		on_attach = lspconfig_config.on_attach,
		on_init = lspconfig_config.on_init,
		flags = lspconfig_config.flags,
		capabilities = capabilities,
		settings = lspconfig_config.get_server_settings(server.name)
	}

	if server.name == "rust_analyzer" then
		local has_rust_tools, rust_tools = pcall(require, "rust-tools")
		if has_rust_tools then
			rust_tools.setup({ server = opts })
			goto continue
		end
	end

	server:setup(opts)
	::continue::
end

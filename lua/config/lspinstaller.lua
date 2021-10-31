local lspconfig_config = require 'config.lspconfig'
local lsp_instller = require 'nvim-lsp-installer'
local lsp_installer_servers = require'nvim-lsp-installer.servers'
local M = {}

local autoinstall_servers = {"sumneko_lua"}
for _, name in ipairs(autoinstall_servers) do
	local ok, server = lsp_installer_servers.get_server(name)
	if ok and not server:is_installed() then
		server:install()
	end
end

local capabilities = lspconfig_config.get_capabilities()

lsp_instller.on_server_ready(function(server)
	server:setup{
		on_attach = lspconfig_config.on_attach,
		on_init = lspconfig_config.on_init,
		flags = lspconfig_config.flags,
		capabilities = capabilities,
		settings = lspconfig_config.get_server_settings(server.name)
	}
end)

return M


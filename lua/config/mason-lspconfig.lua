local lspconfig_config = require('config.lspconfig')

local function get_options(server_name)
	return {
		root_dir = function()
			return vim.fn.getcwd()
		end,
		init_options = lspconfig_config.get_server_init_options(server_name),
		on_attach = lspconfig_config.on_attach,
		on_init = lspconfig_config.on_init,
		flags = lspconfig_config.flags,
		capabilities = capabilities,
		settings = lspconfig_config.get_server_settings(server_name)
	}
end

require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers{
	function (server_name) -- default handler (optional)
	   require("lspconfig")[server_name].setup(get_options(server_name))
	end,
	["rust_analyzer"] = function ()
		local opts = get_options(server_name)

		local has_rust_tools, rust_tools = pcall(require, "rust-tools")
		if has_rust_tools then
			rust_tools.setup({
				server = opts,
				tools = {
					inlay_hints = {
						auto = false
					}
				}
			})
		else
		   require("lspconfig")[server_name].setup(opts)
		end
	end
}

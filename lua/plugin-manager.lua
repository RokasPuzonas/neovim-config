-- Register custom commands for plugin manager
vim.cmd [[command! -bang -nargs=+ -complete=customlist,v:lua.require'plugin-manager'.loader_complete PackerLoad lua require('plugin-manager').loader(<f-args>, '<bang>' == '!')]]
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugin-manager').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugin-manager').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugin-manager').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugin-manager').clean()]]
vim.cmd [[command! PackerCompile source lua/plugin-manager.lua | packadd packer.nvim | lua require('plugin-manager').compile()]]

-- Bootstrap packer.nvim. If packer.nvim is not installed, install it.
local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		return fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	end
end

local function create_custom_use(use)
	return function (opts)
		if type(opts) == "string" then
			use(opts)
			return opts
		elseif type(opts) == "table" then
			if opts.load_config then
				local name = vim.split(opts[1], "/")[2]
				if name:match("%.nvim$") then
					name = name:sub(1, -6)
				end
				opts.config_name = name
			end
			if opts.config_name then
				opts.config = ("require('config.%s')"):format(opts.config_name)
			end
			use(opts)

			return opts[1]
		else
			error("What are you doing???")
		end
	end
end

local packer = nil
local function init()
	-- Perform bootstrap
	local packer_bootstrap = bootstrap()

	-- Initialize packer
	if packer == nil then
		packer = require 'packer'
		local util = require 'packer.util'
		packer.init {
			compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer-compiled.lua'),
			disable_commands = true
		}
	end

	-- Reset plugins if already loaded
	packer.reset()

	-- Packer can manage itself
	packer.use 'wbthomason/packer.nvim'

	-- Use plugins
	local use = create_custom_use(packer.use)
	for _, module_name in ipairs{"plugins", "plugins-local"} do
		local ok, use_plugins = pcall(require, module_name)
		if ok then
			assert(type(use_plugins) == "function")
			use_plugins(use)
		end
	end

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end
})

return plugins

local function usePlugins(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Improve startup time when loading lua files.
	-- Temporary solution before PR gets merges. https://github.com/neovim/neovim/pull/15436
	use 'lewis6991/impatient.nvim'

	-- Various lua utilities
	use 'nvim-lua/plenary.nvim'

	-- Tree-sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		config = [[require 'config.treesitter']],
		run = ':TSUpdate'
	}

	-- Emoji file icons
	use { 'kyazdani42/nvim-web-devicons', config = [[require 'config.devicons']] }

	-- Fuzzy file finder
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {
		'nvim-telescope/telescope.nvim',
		config = [[require 'config.telescope']],
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-treesitter/nvim-treesitter'},
			{'kyazdani42/nvim-web-devicons', opt = true},
			{'nvim-telescope/telescope-fzf-native.nvim', opt = true}
		}
	}

	-- Smooth smooth scrolling
	use 'psliwka/vim-smoothie'

	-- Toggle comments
	use 'tpope/vim-commentary'

	-- Color code colorizer
	use { 'norcalli/nvim-colorizer.lua', config = [[require 'config.colorizer']] }

	-- Quick movement
	use { 'justinmk/vim-sneak', config = [[require 'config.sneak']] }
	use { 'unblevable/quick-scope', config = [[require 'config.quickscope']] }
	use 'michaeljsmith/vim-indent-object'

	-- Color themes
	use { 'morhetz/gruvbox', module = 'themes.gruvbox' }

	-- Git integration
	use { 'tpope/vim-fugitive', config = [[require 'config.fugitive']] }
end

-- Register custom commands for plugin manager
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- Run "PackerCompile" whenever this file is updated
vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]]

-- Bootstrap packer.nvim. If packer.nvim is not installed, install it.
local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	local packer_bootstrap
	if fn.empty(fn.glob(install_path)) > 0 then
		return fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

	-- Use plugins
	usePlugins(packer.use, packer.use_rocks)

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
	end,
})

return plugins


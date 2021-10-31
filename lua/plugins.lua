
local function usePlugins(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Improve startup time when loading lua files.
	-- Temporary solution before PR gets merges. https://github.com/neovim/neovim/pull/15436
	use 'lewis6991/impatient.nvim'

	-- Reload lua configs
	use {
		'famiu/nvim-reload',
		requires = 'nvim-lua/plenary.nvim',
		config = [[require 'config.reload']]
	}

	-- Provides mappings for working with symbols like (), {}, [], etc.
	use 'tpope/vim-surround'

	-- Allow repeating
	use 'tpope/vim-repeat'

	-- Tree-sitter
	use {
		'nvim-treesitter/nvim-treesitter',
		config = [[require 'config.treesitter']],
		run = ':TSUpdate'
	}

	-- Fuzzy file finder
	use {
		'nvim-telescope/telescope.nvim',
		config = [[require 'config.telescope']],
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			{'kyazdani42/nvim-web-devicons', config = [[require('nvim-web-devicons').setup()]]},
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
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

	-- File browser
	-- use 'tpope/vim-vinegar'
	use {
		'lambdalisue/fern.vim',
		config = [[require 'config.fern']],
		requires = {
			'antoinemadec/FixCursorHold.nvim',
			'lambdalisue/fern-hijack.vim',
			{'lambdalisue/fern-renderer-nerdfont.vim', config = [[vim.g["fern#renderer"] = "nerdfont"]]},
			'lambdalisue/nerdfont.vim'
		}
	}

	-- UNIX commands
	use 'tpope/vim-eunuch'

	-- Snippets
	use 'L3MON4D3/LuaSnip'

	-- Movement utilities
	use 'tpope/vim-unimpaired'

	-- LSP config
	use {
		'neovim/nvim-lspconfig',
		config = [[require 'config.lspconfig']],
	}
	use {
		'williamboman/nvim-lsp-installer',
		requires = 'neovim/nvim-lspconfig',
		config = [[require 'config.lspinstaller']]
	}

	-- Completion
	use { 'onsails/lspkind-nvim' }
	use {
		'hrsh7th/nvim-cmp',
		-- requires = 'onsails/lspkind-nvim', -- For some reason breaks with this line
		requires = {'saadparwaiz1/cmp_luasnip'},
		after = 'lspkind-nvim',
		config = [[require 'config.cmp']],
		event = 'InsertEnter *'
	}
	use {'tzachar/cmp-tabnine', after = 'nvim-cmp', run='./install.sh', requires = 'hrsh7th/nvim-cmp', config = [[require 'config.tabnine']]}
	use {'hrsh7th/cmp-nvim-lsp', requires = {'hrsh7th/nvim-cmp', 'nvim-lspconfig'}}
	use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-buffer', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-path', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp', requires = {'L3MON4D3/LuaSnip', 'nvim-cmp'}}

	-- Color themes
	use 'morhetz/gruvbox'
	use 'tomasr/molokai'
	use 'Mangeshrex/uwu.vim'
	use 'ayu-theme/ayu-vim'
	use 'sickill/vim-monokai'
	use 'joshdick/onedark.vim'
	use 'srcery-colors/srcery-vim'
	use 'mswift42/vim-themes'
	use 'squarefrog/tomorrow-night.vim'
	use 'fnune/base16-vim'

	-- Git integration
	use { 'tpope/vim-fugitive', config = [[require 'config.fugitive']] }
end

-- Register custom commands for plugin manager
vim.cmd [[command! -bang -nargs=+ -complete=customlist,v:lua.require'plugins'.loader_complete PackerLoad lua require('plugins').loader(<f-args>, '<bang>' == '!')]]
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


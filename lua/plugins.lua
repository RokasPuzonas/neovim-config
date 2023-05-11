-- TODO: Add minimal plugin mode. Disables all plugins which are not super
-- important, to get better performance.

---@diagnostic disable-next-line: unused-local
local function usePlugins(use, use_rocks)
	-- Toggle terminal
	use {'akinsho/toggleterm.nvim', tag = '*', config=[[require('toggleterm').setup()]]}

	-- Debugger
	use { 'mfussenegger/nvim-dap', config=[[require('config.dap')]]}
	use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap", config=[[require('dapui').setup()]] }
	use 'simrat39/rust-tools.nvim'
	use {
		'theHamsta/nvim-dap-virtual-text',
		requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
		config=[[require('nvim-dap-virtual-text')]]
	}

	-- Seemless pane switching betwen tmux and vim
	use 'christoomey/vim-tmux-navigator'

	-- UNIX commands
	use 'tpope/vim-eunuch'

	-- Movement utilities
	use 'tpope/vim-unimpaired'

	-- LSP
	use {
		'neovim/nvim-lspconfig',
		config = [[require 'config.lspconfig']],
	}
	use {
		'williamboman/nvim-lsp-installer',
		requires = 'neovim/nvim-lspconfig',
		config = [[require 'config.lspinstaller']]
	}

	-- LSP utils
	use {"ray-x/lsp_signature.nvim", config = [[require 'config.lspsignature']]}
	use {
		'RishabhRD/nvim-lsputils',
		config = [[require 'config.lsputils']],
		requires = 'RishabhRD/popfix'
	}

	-- Snippets
	use { 'L3MON4D3/LuaSnip', config = [[require 'config.luasnip']] }

	-- Completion
	use { 'onsails/lspkind-nvim' }
	use {
		'hrsh7th/nvim-cmp',
		-- requires = 'onsails/lspkind-nvim', -- For some reason breaks with this line
		requires = {'saadparwaiz1/cmp_luasnip'},
		after = 'lspkind-nvim',
		config = [[require 'config.cmp']]
	}
	use {'tzachar/cmp-tabnine', after = 'nvim-cmp', run='./install.sh', requires = 'hrsh7th/nvim-cmp', config = [[require 'config.tabnine']]}
	use {'hrsh7th/cmp-nvim-lsp', requires = {'hrsh7th/nvim-cmp', 'nvim-lspconfig'}}
	use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-buffer', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-path', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp', requires = {'L3MON4D3/LuaSnip', 'nvim-cmp'}}

	-- Better diagnostics viewer
	use {
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = [[require 'config.trouble']]
	}

	-- Color themes
	use 'srcery-colors/srcery-vim'
	-- use 'morhetz/gruvbox'
	-- use 'tomasr/molokai'
	-- use 'Mangeshrex/uwu.vim'
	-- use 'ayu-theme/ayu-vim'
	-- use 'sickill/vim-monokai'
	-- use 'joshdick/onedark.vim'
	-- use 'mswift42/vim-themes'
	-- use 'squarefrog/tomorrow-night.vim'
	-- use 'fnune/base16-vim'

	-- Text object target
	use 'wellle/targets.vim'

	-- Git integration
	use { 'tpope/vim-fugitive', config = [[require 'config.fugitive']] }
	use {
		'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = [[require 'config.gitsigns']]
		-- tag = 'release' -- To use the latest release
	}

	-- Refactoring
	-- use {
	-- 	"ThePrimeagen/refactoring.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter"
	-- 	},
	-- 	disable = true,
	-- 	config = [[require 'config.refactoring']]
	-- }

	-- Analyze startup time
	use 'tweekmonster/startuptime.vim'

	-- Status line and tab line
	use { 'itchyny/lightline.vim', config = [[require 'config.lightline']]}

	-- Load project specific settings from exrc
	use { 'jenterkin/vim-autosource', config = [[require 'config.autosource']] }

	-- Remove spaces at end of lines
	use{ "mcauley-penney/tidy.nvim", config = [[require("tidy").setup()]] }

	-- Training plugins
	-- use 'tjdevries/train.nvim'
	-- use 'ThePrimeagen/vim-be-good'

	-- Quick movement
	-- use { 'justinmk/vim-sneak', config = [[require 'config.sneak']] }
	use { 'unblevable/quick-scope', config = [[require 'config.quickscope']] }
	use 'michaeljsmith/vim-indent-object'
	use { 'ggandor/leap.nvim', config=[[require('leap').add_default_mappings()]]}

	-- Smooth smooth scrolling
	-- use { 'karb94/neoscroll.nvim', config = [[require('neoscroll').setup()]] }
	use 'psliwka/vim-smoothie'

	-- Commenting
	use {
		'terrortylor/nvim-comment',
		config = [[require 'config.comment']],
		requires = 'JoosepAlviste/nvim-ts-context-commentstring'
	}

	-- Color code colorizer
	use { 'norcalli/nvim-colorizer.lua', config = [[require 'config.colorizer']] }

	-- Fuzzy file finder
	use {
		'nvim-telescope/telescope.nvim',
		config = [[require 'config.telescope']],
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
			'kyazdani42/nvim-web-devicons',
			{'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
		}
	}

	-- Align characters vertically
	use 'godlygeek/tabular'

	-- Used for loading project specific code styles
	use 'editorconfig/editorconfig-vim'

	-- Provides mappings for working with symbols like (), {}, [], etc.
	use 'tpope/vim-surround'

	-- Allow repeating
	use 'tpope/vim-repeat'

	-- GLSL language support
	use 'tikhomirov/vim-glsl'

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		config = [[require 'config.treesitter']],
		run = function() require('nvim-treesitter.install').update{ with_sync = true } end
	}
	use {
		'nvim-treesitter/playground',
		requires = 'nvim-treesitter/nvim-treesitter',
		cmd = "TSPlaygroundToggle"
	}

	-- Dev icons
	use {'kyazdani42/nvim-web-devicons', config = [[require('nvim-web-devicons').setup()]]}

	-- Zen mode
	use { 'folke/zen-mode.nvim', config = [[require 'config.zen-mode']] }
	use {
		'folke/twilight.nvim',
		requires = 'folke/zen-mode.nvim',
		config = [[require 'config.twilight']]
	}

	-- File browser
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = [[require 'config.nvim-tree']]
	}
	-- use {
	-- 	'lambdalisue/fern.vim',
	-- 	config = [[require 'config.fern']],
	-- 	requires = {
	-- 		'antoinemadec/FixCursorHold.nvim',
	-- 		'lambdalisue/fern-hijack.vim',
	-- 		{'lambdalisue/fern-renderer-nerdfont.vim', config = [[vim.g["fern#renderer"] = "nerdfont"]]},
	-- 		'lambdalisue/nerdfont.vim'
	-- 	}
	-- }
	-- alternatives:
	-- use 'kyazdani42/nvim-tree.lua'
	-- use 'zgpio/tree.nvim'
	-- use 'tpope/vim-vinegar'
end

-- Register custom commands for plugin manager
vim.cmd [[command! -bang -nargs=+ -complete=customlist,v:lua.require'plugins'.loader_complete PackerLoad lua require('plugins').loader(<f-args>, '<bang>' == '!')]]
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile source lua/plugins.lua | packadd packer.nvim | lua require('plugins').compile()]]

-- Bootstrap packer.nvim. If packer.nvim is not installed, install it.
local function bootstrap()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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

	-- Packer can manage itself
	packer.use 'wbthomason/packer.nvim'

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

-- TODO: Add minimal plugin mode. Disables all plugins which are not super
-- important, to get better performance.

return function(use)
	local function use_config(name)
		use(require(("config.%s"):format(name)))
	end

	use_config "toggleterm"
	use_config "baleia"
	use_config "todo-comments"
	use_config "legendary"
	use_config "dressing"
	use_config "move"
	use_config "gitblame"
	use_config "based"
	use_config "lspsignature"
	use_config "lsputils"
	use_config "luasnip"
	use_config "trouble"
	use_config "fugitive"
	use_config "gitsigns"
	use_config "nvim-tree"
	use_config "autosource"
	use_config "tidy"
	use_config "quickscope"
	use_config "leap"
	use_config "comment"
	use_config "colorizer"
	use_config "devicons"
	use_config "treesitter"
	use_config "ts-playground"

	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"kyazdani42/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
			{"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
		},
		load_config = true
	}

	use {
		"neovim/nvim-lspconfig",
		config_name = "lspconfig"
	}

	use {
		'williamboman/nvim-lsp-installer',
		requires = 'neovim/nvim-lspconfig',
		config_name = "lspinstaller"
	}

	use {
		"nvim-lualine/lualine.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		load_config = true
	}

	use {
		'rafcamlet/nvim-luapad',
		config_name = "luapad"
	}

	use "tpope/vim-eunuch"
	use "christoomey/vim-tmux-navigator"
	use "eandrju/cellular-automaton.nvim"
	use "tweekmonster/startuptime.vim"
	use "tpope/vim-unimpaired"
	use { "sindrets/diffview.nvim", requires = 'nvim-lua/plenary.nvim' }
	use "wellle/targets.vim"
	use "michaeljsmith/vim-indent-object"
	use "psliwka/vim-smoothie"
	use "godlygeek/tabular"
	use "editorconfig/editorconfig-vim"
	use "tpope/vim-surround"
	use "tpope/vim-repeat"
	use "tikhomirov/vim-glsl"

	-- Debugger
	use { "mfussenegger/nvim-dap", config_name="dap" }
	use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap", config=[[require('dapui').setup()]] }
	use 'simrat39/rust-tools.nvim'
	use {
		'theHamsta/nvim-dap-virtual-text',
		requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
		config=[[require('nvim-dap-virtual-text')]]
	}

	-- Completion
	use { 'onsails/lspkind-nvim' }
	use {
		'hrsh7th/nvim-cmp',
		-- requires = 'onsails/lspkind-nvim', -- For some reason breaks with this line
		requires = {'saadparwaiz1/cmp_luasnip'},
		after = 'lspkind-nvim',
		config_name = "cmp"
	}
	use {'tzachar/cmp-tabnine', after = 'nvim-cmp', run='./install.sh', requires = 'hrsh7th/nvim-cmp', config_name = "tabnine"}
	use {'hrsh7th/cmp-nvim-lsp', requires = {'hrsh7th/nvim-cmp', 'nvim-lspconfig'}}
	use {'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-buffer', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-path', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp', requires = 'hrsh7th/nvim-cmp'}
	use {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp', requires = {'L3MON4D3/LuaSnip', 'nvim-cmp'}}

	do -- Color themes
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
	end

	-- Training plugins
	-- use 'tjdevries/train.nvim'
	-- use 'ThePrimeagen/vim-be-good'
end

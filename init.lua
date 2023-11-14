vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "python3.10"

-- If possible use 24 Bit Colors
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

-- Bootstrap lazy.nvim
do
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
end

require("lazy").setup({
  "psliwka/vim-smoothie",
	"tpope/vim-unimpaired",
  "tpope/vim-eunuch",
  "tpope/vim-surround",
	"tpope/vim-repeat",
  {"christoomey/vim-tmux-navigator", lazy=false},
  "michaeljsmith/vim-indent-object",
  "godlygeek/tabular",
	"mcauley-penney/tidy.nvim",
  "editorconfig/editorconfig-vim",
  "kevinhwang91/nvim-bqf",
  "wellle/targets.vim",

  {
    "krady21/compiler-explorer.nvim",
    cmd = {"CECompile", "CECompileLive", "CEFormat", "CEAddLibrary", "CELoadExample", "CEOpenWebsite", "CEDeleteCache", "CEShowTooltip", "CEGotoLabel"}
  },

  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open lazygit" }
    }
  },

  {
    "unblevable/quick-scope",
    init = function ()
      -- Trigger a highlight in the appropriate direction when pressing these keys:
      vim.g.qs_highlight_on_keys = {"f", "F", "t", "T"}
      vim.g.qs_max_chars = 150
    end
  },

  {
    "stevearc/dressing.nvim",
    dependencies = {"nvim-telescope/telescope.nvim"},
    opts = {
			select = {
				get_config = function(opts)
					opts = opts or {}
					local cfg = {
						telescope = {
							layout_config = {
								-- width = 120,
								-- height = 60,
								width = 0.87,
								height = 0.80,
							},
						},
					}
					if opts.kind == "legendary.nvim" then
						cfg.telescope.sorter = require("telescope.sorters").fuzzy_with_index_bias({})
					end
					return cfg
				end,
			},
    }
  },

  { "tikhomirov/vim-glsl", ft="glsl" },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim"},
    opts = { signs = false }
  },

  -- Git related plugins
  {
    "f-person/git-blame.nvim",
    config = function ()
      vim.g["gitblame_enabled"] = 0
      vim.g["gitblame_date_format"] = "%r"
    end,
    keys = {
      { "<leader>gh", "<cmd>GitBlameCopySHA<cr>"   , desc = "[G]it blame, copy commit [h]ash" },
      { "<leader>go", "<cmd>GitBlameOpenCommit<cr>", desc = "[G]it blame, [o]pen commit" },
      { "<leader>gt", "<cmd>GitBlameToggle<cr>"    , desc = "[G]it blame, [t]oggle" },
    }
  },

  {
    "trmckay/based.nvim",
    keys = {
      { mode = {"n", "v"}, "<leader>b", function(...) require("based").convert(...) end, desc = "Convert [b]ase of number" }
    }
  },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  {
    "ray-x/lsp_signature.nvim",
    opts = {
      hint_enable = false,
      toggle_key = nil,
      handler_opts = {
        border = { " ", " ", " ", " ", " ", " ", " ", " "  }
      }
    }
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
  },

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function()
        local function keymap(mode, keybind, cmd, desc)
          vim.keymap.set(mode, keybind, cmd, {desc=desc, buffer=true})
        end
        keymap({"v","n"}, "<leader>hs", ":Gitsigns stage_hunk<CR>", "[h]unk [s]tage")
        keymap({"v","n"}, "<leader>hr", ":Gitsigns reset_hunk<CR>", "[h]unk [r]eset")
        keymap("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", "[h]unk [S]tage buffer")
        keymap("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", "[h]unk [u]ndo stage")
        keymap("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", "[h]unk [R]eset buffer")
        keymap("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", "[h]unk [p]review")
        keymap("n", "<leader>ht", "<cmd>Gitsigns toggle_deleted<CR>", "[h]unk [t]oggle deleted")
      end
    },
  },

  {
    "nvim-treesitter/playground",
    requires = "nvim-treesitter/nvim-treesitter",
    cmd = "TSPlaygroundToggle"
  },

  {
    "sindrets/diffview.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    opts = {
      enhanced_diff_hl = true
    },
    keys = {
      {"<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "[g]it [d]iff [o]pen" },
      {"<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "[g]it [d]iff [c]pen" }
    }
  },

  {
    "vim-scripts/DoxygenToolkit.vim",
    cmd = "Dox",
    config = function()
      vim.g.DoxygenToolkit_startCommentTag = "/// "
      vim.g.DoxygenToolkit_interCommentTag = "/// "
      vim.g.DoxygenToolkit_endCommentTag = ""
      vim.g.DoxygenToolkit_startCommentBlock = "// "
      vim.g.DoxygenToolkit_interCommentBlock = "// "
      vim.g.DoxygenToolkit_endCommentBlock = ""
    end
  },

  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim"
    },
    keys = {
      {"<leader>o", "<cmd>Navbuddy<cr>", desc="Navbuddy"}
    },
    opts = {
      window = {
        border = "rounded",
        size = "60%",
        position = "50%",
        sections = {
          left  = { size = "20%" },
          mid   = { size = "40%" },
          right = { preview = "leaf" }
        },
      },
      node_markers = { enabled = true },
      use_default_mappings = true,
      lsp = { auto_attach = true }
    }
  },

  {
    "m-gail/escape.nvim",
    keys = {
      {mode="v", "<leader>q", function(...) return require("escape").escape(...) end, desc="Escape [q]uotes"}
    }
  },

  {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    keys = {
      {mode="n", "<leader>n", "<Plug>RestNvim", desc = "Run HTTP request under cursor"}
    }
  },

  {
    "jenterkin/vim-autosource",
    config = function()
      local data = vim.fn.stdpath("data")
      vim.g.autosource_hashdir = data .. "/vim-autosource/hashes"
    end
  },

  {
    "fedepujol/move.nvim",
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set("v", "<S-j>", ":MoveBlock(1)<CR>", opts)
      vim.keymap.set("v", "<S-k>", ":MoveBlock(-1)<CR>", opts)
    end,
  },

  {
    "srcery-colors/srcery-vim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("srcery")
    end,
  },

  {
    "rafcamlet/nvim-luapad",
    cmd = {"Luapad", "LuaRun"},
    init = function()
      local pattern = "^/tmp/.*/%d+_Luapad%.lua$"
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("LuaPadFiletype", {clear=true}),
        callback = function(data)
          if data.file:match(pattern) then
            vim.bo[data.buf].filetype = "lua.luapad"
          end
        end
      })
    end
  },

  -- {
  --   -- Set lualine as statusline
  --   "nvim-lualine/lualine.nvim",
  --   -- See `:help lualine.txt`
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       theme = "srcery",
  --       component_separators = "|",
  --       section_separators = "",
  --     },
  --   },
  -- },

  -- {
  --   -- Add indentation guides even on blank lines
  --   "lukas-reineke/indent-blankline.nvim",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   main = "ibl",
  --   opts = {},
  -- },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  {
    "norcalli/nvim-colorizer.lua",
    lazy = false,
    config = function()
      require("colorizer").setup(
        nil,
        {
          RGB      = true,
          RRGGBB   = true,
          names    = false,
          RRGGBBAA = true,
          rgb_fn   = true,
          hsl_fn   = true,
          css      = false,
          css_fn   = false,
          mode     = "background"
        }
      )
    end
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    build = ":TSUpdate",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tre[e]" },
      { "<leader>f", "<cmd>Neotree reveal toggle<cr>", desc = "Toggle file tre[e] (file)" },
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["<c-v>"] = "open_vsplit",
            ["<c-x>"] = "open_split"
          }
        },
        filesystem = {
          group_empty_dirs = false
        }
      })
    end
  },

  -- TODO: When updating throws an error
  -- {
  --   "m00qek/baleia.nvim",
  --   tag = "v1.2.0",
  --   config = function()
  --     local baleia = require("baleia").setup()
  --     vim.api.nvim_create_user_command("BaleiaColorize", function()
  --       baleia.once(vim.api.nvim_get_current_buf())
  --     end, { })
  --   end,
  --   keys = {
  --     { id = "[A]NSI [C]olorize", "<leader>ac", "<cmd>BaleiaColorize<cr>", desc = "Colorize ANSI codes" }
  --   }
  -- },


  -- TODO: Setup DAP
	-- use { "mfussenegger/nvim-dap", config_name="dap" }
	-- use { "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap", config=[[require("dapui").setup()]] }
	-- use "simrat39/rust-tools.nvim"
	-- use {
	-- 	"theHamsta/nvim-dap-virtual-text",
	-- 	requires = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
	-- 	config=[[require("nvim-dap-virtual-text")]]
	-- }

  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end
  },

  {
    dir = "personal/cmacro-align",
    config = function() require("personal.cmacro-align").load() end
  },

  {
    dir = "personal/add-include-guard",
    config = function() require("personal.add-include-guard").load() end,
    cmd = "AddIncludeGuard"
  },

  {
    dir = "personal/plugin-dev",
    config = function() require("personal.plugin-dev").load() end,
  },

  {
    dir = "personal/uci",
    config = function() require("personal.uci").load() end,
    ft="uci"
  },

  {
    dir = "personal/disable-builtin",
    lazy = false,
    config = function() require("personal.disable-builtin").load() end,
  },

  { import = "plugins" }
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Enable auto reload of changed files
do
  vim.o.autoread = true
  -- TODO:
  -- local autoreload_grp = vim.api.nvim_create_augroup("AutoReload", { clear = true })
  -- vim.api.nvim_create_autocmd({"FocusGained","BufEnter","CursorHold","CursorHoldI"}, {
  --   group = autoreload_grp,
  --   pattern = {"*"},
  --   callback = function()
  --     -- TODO: Port this to lua
  --     vim.cmd [[if mode() != "c" | checktime | endif]]
  --   end
  -- })
  -- vim.api.nvim_create_autocmd({"FileChangedShellPost"}, {
  --   group = autoreload_grp,
  --   pattern = {"*"},
  --   callback = function()
  --     -- TODO: Port this to lua
  --     vim.cmd [[echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]
  --   end
  -- })
  -- autocmd("auto-reload", {
  --   [[FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != "c" | checktime | endif]],
  --   [[FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]]
  -- }, true)
end

do
  -- TODO: Use nvim API
  vim.cmd.syntax("on")
  vim.cmd.filetype("plugin on")

  vim.g.zig_fmt_autosave = 0

  -- Folding options
  vim.o.foldmethod = "indent"
  vim.o.foldlevelstart = 99

  -- Identation/Tab settings
  local tab_size = 2
  vim.bo.expandtab = true
  vim.bo.smartindent = true
  vim.bo.shiftwidth = tab_size
  vim.bo.tabstop = tab_size
  vim.bo.softtabstop = tab_size

  vim.g.python_ident = {
    disable_parentheses_indenting = false,
    closed_paren_align_last_line = false,
    searchpair_timeout = 150,
    continue = "shiftwidth()",
    open_paren = "shiftwidth()",
    nested_paren = "shiftwidth()"
  }

  -- Set highlight on search
  vim.o.hlsearch = false
  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.incsearch = true
  vim.o.inccommand = "nosplit"

  -- Always keep at least 8 blank lines below the last line
  vim.o.scrolloff = 8

  -- Show 110 marker column
  vim.o.colorcolumn = "110"

  -- How whitespace characters should be displayed
  vim.o.listchars = [[space:.,eol:$,tab:>-]]

  -- Show current mode that you are in
  vim.o.showmode = true

  -- Add a bit of transparency to windows
  vim.o.pumblend = 15
  vim.cmd.highlight("PmenuSel blend=0") -- TODO: use nvim API

  -- Keep non-visible files open
  vim.o.hidden = true

  -- Make line numbers default + relative numbers
  vim.wo.number = true
  vim.wo.relativenumber = true

  -- Enable mouse mode
  vim.o.mouse = "a"

  -- Skip redrawing window while executing macro
  vim.o.lazyredraw = true

  -- Sync clipboard between OS and Neovim.
  vim.o.clipboard = "unnamedplus"

  -- Enable break indent
  vim.o.breakindent = true

  -- Save undo history
  vim.o.undofile = true

  -- Keep signcolumn on by default
  vim.wo.signcolumn = "yes"

  -- Decrease update time
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300

  -- Place splits below and to the right by default
  vim.o.splitbelow = true
  vim.o.splitright = true

  -- By default don"t wrap text
  vim.o.wrap = false

  -- Remove cmdline when not used
  vim.o.cmdheight = 0

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = "menuone,noselect"

  -- Scale neovide a bit
  if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.75
    vim.g.neovide_hide_mouse_when_typing = true
  end
end

-- [[ Basic Keymaps ]]

do
  -- Keymaps for better default experience
  -- See `:help vim.keymap.set()`
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Better movement between tabs
  vim.keymap.set("n", "<C-Left>", ":tabprevious<cr>", { silent = true })
  vim.keymap.set("n", "<C-Right>", ":tabnext<cr>", { silent = true })

  -- Better indenting
  vim.keymap.set("v", "<", "<gv")
  vim.keymap.set("v", ">", ">gv")

  -- Save file
  vim.keymap.set("n", "<C-s>", ":w<cr>", { silent = true })

  -- Disable Ex mode
  vim.keymap.set("n", "Q", "<nop>")

  -- Window movement
  vim.g.tmux_navigator_no_mappings = 1
  vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent=true })
  vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<CR>", { noremap = true, silent=true })
  vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<CR>", { noremap = true, silent=true })
  vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<CR>", { noremap = true, silent=true })

  -- Resize windows
  vim.keymap.set('n', '<M-j>', ':resize -2<cr>', { silent = true })
  vim.keymap.set('n', '<M-k>', ':resize +2<cr>', { silent = true})
  vim.keymap.set('n', '<M-h>', ':vertical resize -2<cr>', { silent = true })
  vim.keymap.set('n', '<M-l>', ':vertical resize +2<cr>', { silent = true })
end

-- Change c file comment string
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("set-c-commentstring", { clear = true }),
	pattern = {"c", "cc", "cpp", "h", "hpp"},
	callback = function(data)
		vim.api.nvim_buf_set_option(data.buf, "commentstring", "// %s")
	end
})

-- Override `ft` for .h files to `c`
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("override-c-header-ft", { clear = true }),
	pattern = "cpp",
	callback = function(data)
		if data.file:match("%.h$") then
			vim.api.nvim_buf_set_option(data.buf, "ft", "c")
		end
	end
})

-- Remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Move between windows easier in terminal windows
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Add abbreviation for != => ~= in lua files
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("MyTermOpen", { clear = true }),
	pattern = "*.lua",
	callback = function()
		vim.api.nvim_cmd({ cmd = "abb", args = {"<buffer>", "!=", "~="}}, {})
	end
})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of "nvim {filename}"
vim.defer_fn(function()
  require("nvim-treesitter.configs").setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "javascript", "typescript", "vimdoc", "vim" },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  }
end, 0)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>dm", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don"t have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  --nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
end

-- document existing key chains
require("which-key").register({
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
  ["<leader>h"] = { name = "More git", _ = "which_key_ignore" },
  ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property "filetypes" to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { "html", "twig", "hbs"} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require "cmp"
local luasnip = require "luasnip"
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup {}

local lspkind = require("lspkind")
lspkind.init()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete {},
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", max_item_count = 10, keyword_length = 5 },
  },
	formatting = {
		format = lspkind.cmp_format{ with_text = true }
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	}
}

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" }
	}
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- Falling back to find_files if git_files can't find a .git directory
local function project_files()
	local opts = { prompt_title = 'Project files' }
	local ok = pcall(builtin.git_files, opts)
	if not ok then builtin.find_files(opts) end
end

local function edit_config()
	return M.project_files{
		cwd = "~/.config/nvim",
		prompt_title = "Neovim config"
	}
end

telescope.setup{
	defaults = {
		vimgrep_arguments = {
			"rg",
			"-L",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = { mirror = false },
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		color_devicons = true,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = { ["<esc>"] = actions.close }
		},
	},
	pickers = {
		live_grep = {
			disable_coordinates = true
		},
		colorscheme = {
			enable_preview = true
		}
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	}
}

telescope.load_extension("ui-select")

local fzfPlugin = packer_plugins["telescope-fzf-native.nvim"]
if fzfPlugin and fzfPlugin.loaded then
	telescope.load_extension('fzf')
end


local silent = {silent = true}

-- Search project files
vim.keymap.set("n", "<C-p>", project_files, silent)

-- Search files from current working directory
vim.keymap.set("n", "<leader>p", function() builtin.find_files() end, silent)

-- Edit neovim config
vim.keymap.set("n", "<leader>ce", edit_config, silent)

-- Find string
vim.keymap.set("n", "<leader>fw", function() builtin.live_grep() end, silent)

-- Change colorscheme
vim.keymap.set("n", "<leader>cs", function() builtin.colorscheme() end, silent)

-- See help tags
vim.keymap.set("n", "<leader>fh", function() builtin.help_tags() end, silent)

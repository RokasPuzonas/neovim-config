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

local function get_vtext()
	local prev_regv = vim.fn.getreg('v')
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg("v", prev_regv)

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

local function escape_sed_symbols(text)
	return text:gsub("[.()%[%]]", "\\%1")
end

local keymaps = {
	-- Search project files
	{ "<C-p>", project_files, description = "Open git files" },

	-- Search files from current working directory
	{ "<leader>p", function() builtin.find_files() end, description = "Open files" },

	-- Edit neovim config
	{"<leader>ce", edit_config, description = "Edit neovim config" },

	-- Grep string
	{ "<leader>fw", {
		n = function() builtin.live_grep() end,
		v = function(a)
			local text = escape_sed_symbols(get_vtext())
			builtin.live_grep{ default_text = text }
		end
	}, description = "Grep" },

	-- Change colorscheme
	{ "<leader>cs", function() builtin.colorscheme() end, description = "Change colorscheme" },

	-- See help tags
	{ "<leader>fh", function() builtin.help_tags() end, description = "Search help tags" }
}

local silent = {silent = true}
for _, keymap in ipairs(keymaps) do
	keymap.opts = silent
end

require("legendary").keymaps(keymaps)

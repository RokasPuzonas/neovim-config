local telescope = require('telescope')
local map = require('utils.map')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')
local M = {}

local function sizelimit_maker(filepath, bufnr, opts)
  opts = opts or {}
	local size_limit = 100 * 1024 -- 100KiB

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > size_limit then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

-- Falling back to find_files if git_files can't find a .git directory
function M.project_files(opts)
  local ok = pcall(builtin.git_files, opts)
  if not ok then builtin.find_files(opts) end
end

function M.edit_config(_opts)
	return M.project_files{
		cwd = "~/.config/nvim",
		prompt_title = "Neovim config"
	}
end

local silent = {silent = true}

-- Search project files
map('n', '<C-p>', [[:lua require('config.telescope').project_files()<cr>]], silent)

-- Edit neovim config
map('n', '<leader>ec', [[:lua require('config.telescope').edit_config()<cr>]], silent)

-- Grep string
map('n', '<leader>fg', [[:lua require('telescope.builtin').live_grep()<cr>]], silent)

-- Change colorscheme
map('n', '<leader>cs', [[:lua require('telescope.builtin').colorscheme()<cr>]], silent)

telescope.setup{
	defaults = {
		buffer_previewer_maker = sizelimit_maker,
		path_display = { "shorten" },
		color_devicons = true,
		mappings = {
			i = {
				["<esc>"] = actions.close
			}
		}
	},
	pickers = {
		find_files = {
      theme = "dropdown",
    },
		marks = {
      theme = "dropdown",
    },
		oldfiles = {
      theme = "dropdown",
    },
		git_files = {
      theme = "dropdown",
		},
		live_grep = {
      theme = "dropdown",
			disable_coordinates = true
		},
		colorscheme = {
      theme = "dropdown",
			enable_preview = true
		}
	}
}

local fzfPlugin = packer_plugins["telescope-fzf-native.nvim"]
if fzfPlugin and fzfPlugin.loaded then
	telescope.load_extension('fzf')
end

return M

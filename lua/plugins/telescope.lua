local telescope = require('telescope')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- require('telescope').setup {
--   defaults = {
--     mappings = {
--       i = {
--         ['<C-u>'] = false,
--         ['<C-d>'] = false,
--       },
--     },
--   },
-- }

-- Enable telescope fzf native, if installed
-- pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- Falling back to find_files if git_files can't find a .git directory
local function project_files(opts)
  opts = opts or {}
  if not opts.prompt_title then
    opts.prompt_title = "Project files"
  end
  local ok = pcall(builtin.git_files, opts)
  if not ok then builtin.find_files(opts) end
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

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function() return vim.fn.executable('make') == 1 end,
    }
  },
  config = function()
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
	buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	mappings = {
	  i = { ["<esc>"] = actions.close }
	},
      },
      pickers = {
	live_grep = { disable_coordinates = true },
	colorscheme = { enable_preview = true }
      },
      extensions = {
	["ui-select"] = { require("telescope.themes").get_dropdown {} }
      }
    }

    telescope.load_extension("ui-select")
    pcall(telescope.load_extension, 'fzf') -- Enable telescope fzf native, if installed

    local keymap = vim.keymap.set
    keymap("n", "<C-p>", project_files, { desc = "Find [P]roject files" })
    keymap("n", "<leader>p", function() builtin.find_files() end, { desc = "[P] Find files" })
    keymap("n", "<leader>fw", function() builtin.live_grep() end, { desc = "[F]ind [W]ords" })
    keymap("v", "<leader>fw", function() builtin.live_grep{ default_text = escape_sed_symbols(get_vtext()) } end, { desc = "[F]ind [W]ords" })
    keymap("n", "<leader>fh", function() builtin.help_tags() end, { desc = "Find help tags" })
  end
}

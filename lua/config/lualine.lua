local bg = vim.g.srcery_xgray1

local colors = {
  red = vim.g.srcery_red,
  grey = vim.g.srcery_black,
  black = vim.g.srcery_hard_black,
  white = vim.g.srcery_bright_white,
  light_green = vim.g.srcery_bright_green,
  orange = vim.g.srcery_orange,
  green = vim.g.srcery_green,
}

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = bg },
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.light_green } },
  visual = { a = { fg = colors.black, bg = colors.orange } },
  replace = { a = { fg = colors.black, bg = colors.green } },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
	self.status = ''
	self.applied_separator = ''
	self:apply_highlights(default_highlight)
	self:apply_section_separators()
	return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
	for name, section in pairs(sections) do
		local left = name:sub(9, 10) < 'x'
		for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
			table.insert(section, pos * 2, { empty, color = { fg = bg, bg = bg } })
		end
		for id, comp in ipairs(section) do
			if type(comp) ~= 'table' then
				comp = { comp }
				section[id] = comp
			end
			comp.separator = left and { right = '' } or { left = '' }
		end
	end
	return sections
end

local function search_result()
	local last_search = vim.fn.getreg('/')
	if not last_search or last_search == '' then
		return ''
	end
	local searchcount = vim.fn.searchcount { maxcount = 9999 }
	if searchcount.total == 0 then
		return ''
	end
	return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
	if vim.bo.modified then
		return '+'
	elseif vim.bo.modifiable == false or vim.bo.readonly == true then
		return '-'
	end
	return ''
end

local function recording_macro()
	local reg = vim.api.nvim_call_function("reg_recording", {})
	if reg ~= "" then
		return "@" .. reg
	else
		return ""
	end
end

local extensions = {"man", "quickfix"}
if pcall(require, "nvim-tree") then
	table.insert(extensions, "nvim-tree")
end
if pcall(require, "toggleterm") then
	table.insert(extensions, "toggleterm")
end
if pcall(require, "luapad.statusline") then
	table.insert(extensions, {
		sections = process_sections {
			lualine_a = {'mode'},
			lualine_b = {
				{
					'diagnostics',
					source = { 'nvim' },
					sections = { 'error' },
					diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
				},
				{
					'diagnostics',
					source = { 'nvim' },
					sections = { 'warn' },
					diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
				},
				{ recording_macro, color = { bg = colors.orange } }
			},
			lualine_y = { search_result, 'filetype' },
			lualine_z = { '%l:%c', '%p%%/%L' },
		},
		filetypes = {'lua.luapad'}
	})
end

require('lualine').setup {
	options = {
		theme = theme,
		component_separators = '',
		section_separators = { left = '', right = '' },
		-- ignore_focus = {"NvimTree"},
		globalstatus = true
	},
	sections = process_sections {
		lualine_a = { 'mode' },
		lualine_b = {
			'branch',
			 'diff',
			{
				'diagnostics',
				source = { 'nvim' },
				sections = { 'error' },
				diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
			},
			{
				'diagnostics',
				source = { 'nvim' },
				sections = { 'warn' },
				diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
			},
			{ 'filename', file_status = false, path = 1 },
			{ modified, color = { bg = colors.red } },
			{ '%w', cond = function() return vim.wo.previewwindow end },
			{ '%r', cond = function() return vim.bo.readonly end },
			{ '%q', cond = function() return vim.bo.buftype == 'quickfix' end },
			{ recording_macro, color = { bg = colors.orange } }
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { search_result, 'filetype' },
		lualine_z = { '%l:%c', '%p%%/%L' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	extensions = extensions
}

local bright_white = vim.api.nvim_get_hl(0, { name = 'SrceryBrightWhite' }).fg
local hard_black = vim.api.nvim_get_hl(0, { name = 'SrceryHardBlack' }).fg
local red = vim.api.nvim_get_hl(0, { name = 'SrceryRed' }).fg
local yellow = vim.api.nvim_get_hl(0, { name = 'SrceryYellow' }).fg
local gray1 = vim.api.nvim_get_hl(0, { name = 'SrceryXgray1' }).fg

local TelescopePrompt = {
  TelescopeBorder = { bg = hard_black, fg = hard_black },
  TelescopePromptBorder = { bg = gray1, fg = gray1 },
  TelescopePromptNormal = { bg = gray1 },
  TelescopePromptTitle = { fg = hard_black, bg = red },
  TelescopePreviewTitle = { fg = hard_black, bg = yellow },
  TelescopeNormal = { bg = hard_black, fg = bright_white },
  TelescopeResultsNormal = { bg = hard_black, fg = bright_white },
  TelescopePreviewNormal = { bg = hard_black, fg = bright_white },
  TelescopeSelection = { bg = hard_black, fg = bright_white, underline = true },
}
for hl, col in pairs(TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end

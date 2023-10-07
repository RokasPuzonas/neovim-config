if vim.g.colors_name == "srcery" then
  local bright_white = vim.api.nvim_get_hl_by_name("SrceryBrightWhite", true).foreground
  local hard_black = vim.api.nvim_get_hl_by_name("SrceryHardBlack", true).foreground
  local red = vim.api.nvim_get_hl_by_name("SrceryRed", true).foreground
  local yellow = vim.api.nvim_get_hl_by_name("SrceryYellow", true).foreground
  local gray1 = vim.api.nvim_get_hl_by_name("SrceryXgray1", true).foreground

  local TelescopePrompt = {
    TelescopeBorder        = {bg = hard_black, fg = hard_black},
    TelescopePromptBorder  = {bg = gray1, fg = gray1},
    TelescopePromptNormal  = {bg = gray1},
    TelescopePromptTitle   = {fg = hard_black, bg = red },
    TelescopePreviewTitle  = {fg = hard_black, bg = yellow },
    TelescopeNormal        = {bg = hard_black, fg = bright_white},
    TelescopeResultsNormal = {bg = hard_black, fg = bright_white},
    TelescopePreviewNormal = {bg = hard_black, fg = bright_white},
    TelescopeSelection     = {bg = hard_black, fg = bright_white, underline = true},
  }
  for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

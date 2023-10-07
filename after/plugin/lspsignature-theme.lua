if vim.g.colors_name == "srcery" then
  local hard_black = vim.api.nvim_get_hl_by_name("SrceryHardBlack", true).foreground
  local bright_white = vim.api.nvim_get_hl_by_name("SrceryBrightWhite", true).foreground

  vim.api.nvim_set_hl(0, "FloatBorder", {bg=hard_black, fg=bright_white})
  vim.api.nvim_set_hl(0, "FloatNormal", {bg=hard_black, fg=bright_white})
  vim.api.nvim_set_hl(0, "Pmenu", {bg=hard_black, fg=bright_white})
end

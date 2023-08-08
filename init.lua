local cmd = vim.cmd

table.unpack = unpack

-- Allow loading */init.lua files
package.path = "./?/init.lua;"..package.path

-- Leader/local leader
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

-- Disable some built-in plugins we don't want
require("disable-builtin")
require("highlight-yank")
require("plugin-manager")
require("options")
require("bindings")

require("personal.pludin-dev")
require("personal.add-guard")
require("personal.cmacro-align")
require("personal.uci")

vim.g.python_ident = {
  disable_parentheses_indenting = false,
  closed_paren_align_last_line = false,
  searchpair_timeout = 150,
  continue = "shiftwidth()",
  open_paren = "shiftwidth()",
  nested_paren = "shiftwidth()"
}

-- THEME_BEGIN
cmd("colorscheme srcery")
-- THEME_END
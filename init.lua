local cmd = vim.cmd

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

-- THEME_BEGIN
cmd("colorscheme srcery")
-- THEME_END
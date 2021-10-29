local g = vim.g
local cmd = vim.cmd

-- Allow loading */init.lua files
package.path = "./?/init.lua;"..package.path

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  'matchit',
  'netrw',
  'netrwPlugin',
}

for _, name in ipairs(disabled_built_ins) do
  g['loaded_' .. name] = 1
end

require("impatient")
require("plugins")
require("options")
require("bindings")

require("themes.gruvbox")


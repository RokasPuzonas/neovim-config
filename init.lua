local g = vim.g

-- Allow loading */init.lua files
package.path = "./?/init.lua;"..package.path

-- Leader/local leader
g.mapleader = [[ ]]
g.maplocalleader = [[,]]

require("impatient")
require("plugins")



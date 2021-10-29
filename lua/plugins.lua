local function usePlugins(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Improve startup time when loading lua files.
  -- Temporary solution before PR gets merges. https://github.com/neovim/neovim/pull/15436
  use 'lewis6991/impatient.nvim'

  -- Git integration
  use { 'tpope/vim-fugitive', config = [[require 'config.fugitive']] }
end


-- Register custom commands for plugin manager
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- Run "PackerCompile" whenever this file is updated
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

-- Bootstrap packer.nvim. If packer.nvim is not installed, install it.
local function bootstrap()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  local packer_bootstrap
  if fn.empty(fn.glob(install_path)) > 0 then
    return fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
end

local packer = nil
local function init()
  -- Perform bootstrap
  local packer_bootstrap = bootstrap()

  -- Initialize packer
  if packer == nil then
    packer = require 'packer'
    local util = require 'packer.util'
    packer.init {
      compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer-compiled.lua'),
      disable_commands = true
    }
  end

  -- Reset plugins if already loaded
  packer.reset()

  -- Use plugins
  usePlugins(packer.use, packer.use_rocks)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins


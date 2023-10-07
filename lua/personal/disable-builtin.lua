local M = {}

function M.load()
  local disabled_built_ins = {
    'matchit',
          'netrw',
          'netrwPlugin',
          'netrwSettings',
          'netrwFileHandlers',
  }

  for _, name in ipairs(disabled_built_ins) do
    vim.g['loaded_' .. name] = 1
  end
end

return M

local M = {}

function M.load()
  vim.keymap.set("n", "<leader><leader>x", ":w<cr>:source %<cr>", { silent = true })

  function _G.P(...)
    print(vim.inspect(...))
  end
end

return M

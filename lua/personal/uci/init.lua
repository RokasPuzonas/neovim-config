local M = {}

function M.load()
  -- Setup tree sitter
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.uci = {
    install_info = {
      url = 'git@rpuzonas.com:rpuzonas/tree-sitter-uci.git',
      files = { 'src/parser.c' },
      branch = 'main',
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
    filetype = 'uci',
  }

  -- Determine UCI filetype by contents of file.
  -- If file has no extension and at least one line contains the word "config"
  -- TODO:
  --[[
  vim.filetype.add({
          pattern = {
                  [".*/etc/config/.*"] = "uci",
                  [".*/[^%.]+"] = {
                          priority = -math.huge,
                          function(_, bufnr)
                                  for _, line in ipairs(vim.filetype.getlines(bufnr)) do
                                          if line:find("config") ~= nil then
                                                  return "uci"
                                          end
                                  end
                          end
                  }
          }
  })
  ]]
  --
end

return M

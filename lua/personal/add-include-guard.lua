local M = {}

function M.load()
  -- TODO: Make it work with buffer which don't have a filename yet

  vim.api.nvim_create_user_command("AddIncludeGuard", function(data)
    local bufnr = vim.api.nvim_get_current_buf()
    local name_pattern = data.fargs[1] or "%s_"

    local function formatName(filename)
      local parts = vim.split(filename, "[/\\]", {trimempty=true})
      local last_part = parts[#parts]
      local ext = last_part:match("%.([^%.]+)$")
      local name = last_part:gsub("%.[^%.]+$", "")

      if ext == "h" or ext == "hpp" then
        name = name.."_H"
      end

      return name_pattern:format(name:upper())
    end

    local buf_filename = vim.api.nvim_buf_get_name(bufnr)
    local guard_name = formatName(buf_filename)

    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {
      "#ifndef "..guard_name,
      "#define "..guard_name,
      ""
    })

    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {
      "",
      "#endif //"..guard_name
    })
  end, { nargs="?" })
end

return M

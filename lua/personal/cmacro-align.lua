local M = {}

local ts = vim.treesitter

local function get_ast_root(bufnr)
	local tree = ts.get_parser(bufnr, "c"):parse()
	return tree[1]:root()
end


local function do_lines_match(lines1, lines2)
	if #lines1 ~= lines2 then
		return false
	end
	for i, line1 in ipairs(lines1) do
		if line1 ~= lines2[i] then
			return false
		end
	end
	return true
end

local function format_macros()
	local query = ts.query.parse("c", [[
	(preproc_function_def value: (preproc_arg) @macro_def)
	(preproc_def value: (preproc_arg) @macro_def)
	]])

	local capture_lookup = {}
	for id, name in ipairs(query.captures) do
		capture_lookup[name] = id
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local winnr = vim.api.nvim_get_current_win()

	for _, match in query:iter_matches(get_ast_root(bufnr), bufnr, 0, -1) do
		local macro_def_node = match[capture_lookup.macro_def]
		-- local class_name = ts.get_node_text(class_node, bufnr)
		local start_line = macro_def_node:start()
		local end_line = macro_def_node:end_()

		local lines = vim.api.nvim_buf_get_lines(bufnr, start_line, end_line+1, false)
		local tabstop = tonumber(vim.bo[bufnr].tabstop) or 8

		local new_lines = {}
		for i, line in ipairs(lines) do
			lines[i] = line:match("^(.-)%s*[\\]?$")
			new_lines[i] = lines[i]
		end

		while true do
			local last_line = new_lines[#lines]
			if not last_line then break end
			if last_line:match("^%s*//") or last_line:match("^%s*/%*") or last_line:match("^%s*$") then
				table.remove(lines, #lines)
				end_line = end_line - 1
			else
				break
			end
		end

		if #new_lines > 2 then
			local line_length = 0
			do
				local textwidth  = vim.bo[bufnr].textwidth
				if textwidth and textwidth ~= "" then
					line_length = tonumber(textwidth)
				end

				if line_length <= 0 then
					local colorcolum = vim.wo[winnr].colorcolumn
					if colorcolum and colorcolum ~= "" then
						line_length = tonumber(colorcolum)
					end
				end

				if line_length <= 0 then
					for _, line in ipairs(new_lines) do
						line_length = math.max(line_length, #line+2)
					end
				end
			end

			for i = 1, #new_lines-1 do
				local line = new_lines[i]
				local length = #(line:gsub("\t", (" "):rep(tabstop)))
				lines[i] = line .. (" "):rep(line_length - length-2) .. " \\"
			end

			if not do_lines_match(lines, new_lines) then
				vim.api.nvim_buf_set_lines(bufnr, start_line, end_line+1, false, lines)
			end
		end
	end
end

function M.load()
	local group = vim.api.nvim_create_augroup("UpdateCMacro", { clear = true })
	for _, cmd in ipairs{"InsertLeavePre", "BufWritePre"} do
		vim.api.nvim_create_autocmd(cmd, {
			group = group,
			pattern = {"*.c", "*.h", "*.cpp", "*.hpp", "*.cc"},
			callback = function (data)
				format_macros()
			end
		})
	end
end

return M

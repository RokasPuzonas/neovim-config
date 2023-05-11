local pattern = "^/tmp/.*/%d+_Luapad%.lua$"
local group = vim.api.nvim_create_augroup("LuaPadFiletype", {clear=true})
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(data)
		if data.file:match(pattern) then
			vim.bo[data.buf].filetype = "lua.luapad"
		end
	end
})

require("legendary").commands{
	{ ":Luapad", description = "Open interactive lua" },
	{ ":LuaRun", description = "Run lua from current buffer" }
}

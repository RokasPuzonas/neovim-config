local baleia = require("baleia").setup()
vim.api.nvim_create_user_command("BaleiaColorize", function()
	baleia.once(vim.api.nvim_get_current_buf())
end, { })

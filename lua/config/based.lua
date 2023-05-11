return {
	'trmckay/based.nvim',
	config = function ()
		local based = require("based")
		based.setup{}

		vim.keymap.set({"n", "v"}, "<C-b>", based.convert)

		require("legendary").keymap{
			"<C-b>",
			{ n = based.convert, v = based.convert },
			description = "Convert number to other base"
		}
	end
}

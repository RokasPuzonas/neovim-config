local config = {}

if packer_plugins['nvim-ts-context-commentstring'] and packer_plugins['nvim-ts-context-commentstring'].loaded then
	config.hook = function()
		require("ts_context_commentstring.internal").update_commentstring()
	end
end

require("nvim_comment").setup(config)

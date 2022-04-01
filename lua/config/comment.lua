local config = {}

if packer_plugins['nvim-ts-context-commentstring'] and packer_plugins['nvim-ts-context-commentstring'].loaded then
	config.hook = function()
		if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
	end
end

require("nvim_comment").setup(config)

return {
	"stevearc/dressing.nvim",
	requires = "nvim-telescope/telescope.nvim",
	config = function()
		require('dressing').setup({
			select = {
				get_config = function(opts)
					opts = opts or {}
					local cfg = {
						telescope = {
							layout_config = {
								-- width = 120,
								-- height = 60,
								width = 0.87,
								height = 0.80,
							},
						},
					}
					if opts.kind == 'legendary.nvim' then
						cfg.telescope.sorter = require('telescope.sorters').fuzzy_with_index_bias({})
					end
					return cfg
				end,
			},
		})
	end
}

return {
	'norcalli/nvim-colorizer.lua',
	config = function()
		require('colorizer').setup(
			nil,
			{
				RGB      = true,
				RRGGBB   = true,
				names    = false,
				RRGGBBAA = true,
				rgb_fn   = true,
				hsl_fn   = true,
				css      = false,
				css_fn   = false,
				mode     = 'background'
			}
		)
	end
}

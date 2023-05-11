return {
	"ray-x/lsp_signature.nvim",
	config = function()
		local lsp_signature = require("lsp_signature")

		lsp_signature.setup{
			hint_enable = false,
			toggle_key = nil,
			handler_opts = {
				border = { " ", " ", " ", " ", " ", " ", " ", " "  }
			}
		}

		require("legendary").keymap{
			"<C-x>", lsp_signature.toggle_float_win, description="Toggle signature float"
		}
	end
}

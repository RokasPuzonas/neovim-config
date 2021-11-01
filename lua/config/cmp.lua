-- Setup nvim-cmp.
local lspkind = require('lspkind')
lspkind.init()

local cmp = require('cmp')

cmp.setup{
	completion = { completeopt = 'menu,menuone,noinsert' },
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		-- ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		-- ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},
	sources = {
		{ name = 'emoji', max_item_count = 10, keyword_length = 5 },
		{ name = 'nvim_lua' },

		{ name = 'nvim_lsp', max_item_count = 20 },
		{ name = 'cmp_tabnine' },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer', max_item_count = 10, keyword_length = 5 },
	},
	formatting = {
		format = lspkind.cmp_format{
			with_text = true,
			menu = {
				buffer = "[buf]",
				cmp_tabnine = "[tab9]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
				emoji = "[emoji]"
			}
		}
	},
	experimental = {
		native_menu = false,
		ghost_text = true,
	}
}


-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'path' }
-- 	}, {
-- 		{ name = 'cmdline' }
-- 	})
-- })



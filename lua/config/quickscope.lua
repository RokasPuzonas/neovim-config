return {
	'unblevable/quick-scope',
	config = function ()
		-- Trigger a highlight in the appropriate direction when pressing these keys:
		vim.g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}

		vim.g['qs_max_chars'] = 150
	end
}

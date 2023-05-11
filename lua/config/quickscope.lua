return {
	'unblevable/quick-scope',
	config = function ()
		local g = vim.g
		local cmd = vim.cmd

		-- Trigger a highlight in the appropriate direction when pressing these keys:
		g['qs_highlight_on_keys'] = {'f', 'F', 't', 'T'}

		g['qs_max_chars'] = 150
	end
}

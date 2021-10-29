local map = require 'utils.map'
local g = vim.g

g['sneak#label'] = 1

-- case insensitive sneak
g['sneak#use_ic_scs'] = 1

-- immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
g['sneak#s_next'] = 1

-- remap so I can use , and ; with f and t
map({'n', 'v'}, 'gS', '<plug>Sneak_;')
map({'n', 'v'}, 'gs', '<plug>Sneak_;')
-- map gS <Plug>Sneak_,
-- map gs <Plug>Sneak_;

-- highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
-- highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

-- Emoji prompt
g['sneak#prompt'] = '🔎'


local automaton = require("cellular-automaton")

local timeout = 120

local timer
local function enable_screensaver()
	local group = vim.api.nvim_create_augroup('CellularAutomatonScreenSaver', {clear=true})

	local animations = {}
	for name in pairs(automaton.animations) do
		table.insert(animations, name)
	end

	local function play_random_animation()
		local idx = math.random(#animations)
		local animation_name = animations[idx]
		if animation_name then
			automaton.start_animation(animation_name)
		end
	end

	vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
		group = group,
		callback = function()
			-- TODO: Will vim.defer_fn suffice here?
			timer = vim.loop.new_timer()
			timer:start(timeout * 1000, 0, vim.schedule_wrap(function()
				if timer:is_active() then timer:stop() end
				if not timer:is_closing() then timer:close() end

				play_random_animation()
			end))

			vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
				group = group,
				callback = function()
						if timer:is_active() then timer:stop() end
						if not timer:is_closing() then timer:close() end
				end,
				once = true
			})
		end
	})
end

enable_screensaver()

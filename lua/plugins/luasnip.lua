local function capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

return {
  "L3MON4D3/LuaSnip",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local sn = ls.snippet_node
    local fmt = require("luasnip.extras.fmt").fmt
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node

    local function getCurrentYear()
      return os.date("%Y")
    end

    local function getGitUsername()
      local stdout = capture("git config user.name")
      if stdout == "" then return nil end
      return stdout
    end

    ls.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true
    }

    vim.keymap.set({"i", "s"}, "<c-k>", function()
      if ls.expand_or_jumpable() then
	ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ "i", "s" }, "<c-j>", function()
      if ls.jumpable(-1) then ls.jump(-1) end
    end, { silent = -1 })

    vim.keymap.set({"i"}, "<c-l>", function()
      if ls.choice_active() then ls.change_choice(1) end
    end)

    ls.add_snippets("all", {
      s("MIT", {
	t({"The MIT License (MIT)", "Copyright © "}),
	f(getCurrentYear, {}),
	t(" "),
	d(1, function()
	  return sn(nil, {
	    i(1, getGitUsername() or "<copyright holders>")
	  })
	end, {}),
	t{
	    "",
	    "",
	    "Permission is hereby granted, free of charge, to any person obtaining a copy of",
	    "this software and associated documentation files (the “Software”), to deal in",
	    "the Software without restriction, including without limitation the rights to",
	    "use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies",
	    "of the Software, and to permit persons to whom the Software is furnished to do",
	    "so, subject to the following conditions:",
	    "",
	    "The above copyright notice and this permission notice shall be included in all",
	    "copies or substantial portions of the Software.",
	    "",
	    "THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR",
	    "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,",
	    "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE",
	    "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER",
	    "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,",
	    "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE",
	    "SOFTWARE.",
	}
      })
    })
  end
}

local based = require("based")
based.setup{}

vim.keymap.set({"n", "v"}, "<C-b>", based.convert)

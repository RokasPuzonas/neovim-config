local path = ...
return {
  map = require(... .. ".map"),
  opt = require(... .. ".opt"),
  autocmd = require(... .. ".autocmd"),
}

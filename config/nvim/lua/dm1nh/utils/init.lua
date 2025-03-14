local M = {}

setmetatable(M, {
  __index = function(t, k)
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("utils." .. k)
    return rawget(t, k)
  end,
})

_G.Utils = M

return M

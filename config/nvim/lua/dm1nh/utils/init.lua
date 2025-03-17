local M = {}

setmetatable(M, {
  __index = function(t, k)
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("dm1nh.utils." .. k)
    return rawget(t, k)
  end,
})

_G.Utils = M

return M

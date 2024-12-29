--@see https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight

if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end

vim.print = _G.dd

require("config.lazy")

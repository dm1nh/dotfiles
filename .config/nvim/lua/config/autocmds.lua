local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Fix conceallevel for latex files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("tex_conceal"),
	pattern = { "tex", "bib", "plaintex" },
	callback = function()
		vim.opt_local.conceallevel = 0
		vim.opt_local.wrap = true
		vim.opt_local.spell = false
	end,
})

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Fix conceallevel for tex files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("tex_conceal"),
	pattern = { "tex", "plaintex", "bib" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

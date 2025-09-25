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

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "tex", "bib", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = false
	end,
})

-- turn off syntax in large files
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup("large_file"),
	pattern = "*",
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		local max_lines = 300

		if line_count > max_lines then
			vim.bo.syntax = "off"
			vim.notify("Syntax disabled due to large file (" .. line_count .. " lines)", vim.log.levels.WARN)
		end
	end,
})

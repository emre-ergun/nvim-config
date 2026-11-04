local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "engram.plugins" },
	{ import = "engram.plugins.lsp" },
}, {
	checker = {
		enabled = true,
		notify = false,
		frequency = 86400, -- Check once per day (in seconds) instead of every hour
	},
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			reset = true,
		},
	},
})

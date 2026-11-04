vim.cmd("let g:netrw_banner = 0")

local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

opt.virtualedit = "none"
opt.sidescrolloff = 8

-- tabs and indentations
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false
opt.mouse = "a" -- enables mouse support in all modes

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case sensitive

opt.cursorline = true

-- (Saves a file in ~/.local/state/nvim/undo)
-- Undo files: persistent undo even after closing Neovim
opt.undofile = true

-- Better completion experience for C/C++
opt.completeopt = "menuone,noselect"

-- turn on termguicolors for colorschemes to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard (configured for Linux / Ubuntu server & SSH)
opt.clipboard = "unnamedplus" -- use system clipboard as default clipboard

-- Over SSH sessions, use OSC 52 clipboard so copied text syncs with your local machine's clipboard
if vim.env.SSH_TTY or vim.env.SSH_CLIENT or vim.env.SSH_CONNECTION then
	if vim.fn.has("nvim-0.10") == 1 then
		vim.g.clipboard = {
			name = "OSC 52",
			copy = {
				["+"] = require("vim.ui.clipboard.osc52").copy("+"),
				["*"] = require("vim.ui.clipboard.osc52").copy("*"),
			},
			paste = {
				["+"] = require("vim.ui.clipboard.osc52").paste("+"),
				["*"] = require("vim.ui.clipboard.osc52").paste("*"),
			},
		}
	end
end

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Highlight yanking (supports both Neovim 0.10 and 0.11+)
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		if vim.hl and vim.hl.on_yank then
			vim.hl.on_yank()
		else
			vim.highlight.on_yank()
		end
	end,
})

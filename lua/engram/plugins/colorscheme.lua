return {
	-- NOTE: Monokai Pro (Main Config)
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		config = function()
			local monokai = require("monokai-pro")
			-- Set your preferred mode here: "dark" or "light"
			vim.o.background = "dark"
			monokai.setup({
				transparent_background = false,
				terminal_colors = true,
				devicons = true,
				-- Selects the appropriate palette based on background setting:
				-- Light mode uses 'classic', Dark mode uses 'pro' (or 'spectrum' / 'octagon' / 'machine' / 'ristretto')
				filter = vim.o.background == "light" and "classic" or "pro",
				styles = {
					comment = { italic = true },
					keyword = { bold = true },
					type = { italic = false },
					storageclass = { italic = false },
					structure = { italic = false },
					parameter = { italic = false },
					annotation = { italic = false },
					tag = { italic = false },
					attribute = { italic = false },
				},
				override = function(c)
					return {
						ColorColumn = { bg = c.base.dimmedHigh },
						Pmenu = { bg = c.base.bg, fg = c.base.fg },
						PmenuSel = { bg = c.base.dimmedHigh, fg = "NONE" },
						PmenuSbar = { bg = c.base.bg },
						PmenuThumb = { bg = c.base.dimmedLow },
					}
				end,
			})
			vim.cmd.colorscheme("monokai-pro")
		end,
	},
}

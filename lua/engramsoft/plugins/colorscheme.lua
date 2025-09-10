return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = true -- set to true if you would like to enable transparency

		local bg = "#011628"
		local bg_dark = "#011423"
		local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0"
		local fg_dark = "#B4D0E9"
		local fg_gutter = "#627E97"
		local border = "#547998"

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
			end,
		})

		vim.cmd("colorscheme tokyonight")

		---------------------------------------------------------------------
		-- List of all installed colorschemes (builtin + plugins)
		---------------------------------------------------------------------
		local schemes = {
			"blue",
			"darkblue",
			"default",
			"delek",
			"desert",
			"elflord",
			"evening",
			"habamax",
			"industry",
			"koehler",
			"lunaperche",
			"morning",
			"murphy",
			"pablo",
			"peachpuff",
			"quiet",
			"retrobox",
			"ron",
			"rose-pine",
			"rose-pine-dawn",
			"rose-pine-main",
			"rose-pine-moon",
			"shine",
			"slate",
			"sorbet",
			"tokyonight",
			"tokyonight-day",
			"tokyonight-moon",
			"tokyonight-night",
			"tokyonight-storm",
			"torte",
			"unokai",
			"vim",
			"wildcharm",
			"zaibatsu",
			"zellner",
		}

		local idx = 1

		---------------------------------------------------------------------
		-- Apply a colorscheme safely
		---------------------------------------------------------------------
		local function apply_scheme(i)
			idx = ((i - 1) % #schemes) + 1
			local ok = pcall(vim.cmd.colorscheme, schemes[idx])
			if ok then
				vim.notify("Colorscheme → " .. schemes[idx], vim.log.levels.INFO)
			else
				vim.notify("Failed to load: " .. schemes[idx], vim.log.levels.ERROR)
			end
		end

		---------------------------------------------------------------------
		-- Keymaps
		---------------------------------------------------------------------
		-- Cycle next/previous
		vim.keymap.set("n", "<leader>cn", function()
			apply_scheme(idx + 1)
		end, { desc = "Next colorscheme" })
		vim.keymap.set("n", "<leader>cp", function()
			apply_scheme(idx - 1)
		end, { desc = "Prev colorscheme" })

		-- Reset to Tokyonight (your default)
		vim.keymap.set("n", "<leader>cr", function()
			vim.cmd("colorscheme tokyonight")
			vim.notify("Colorscheme → tokyonight (reset)", vim.log.levels.INFO)
		end, { desc = "Reset to Tokyonight" })
	end,
}

return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local devicons = require("nvim-web-devicons")

		devicons.setup({
			override = {
				-- Removed the 'name' field to prevent E5248
				cmake = { icon = "", color = "#5898d4" },
				yml = { icon = "", color = "#cb2431" },
				dts = { icon = "󰈿", color = "#8fbc8f" },
				dtsi = { icon = "󰈿", color = "#8fbc8f" },
				overlay = { icon = "󰙎", color = "#ff9e64" },
				defconfig = { icon = "⚙", color = "#ff9e64" },
				soc = { icon = "⚙", color = "#ff9e64" },
				sysbuild = { icon = "⚙", color = "#ff9e64" },
				modules = { icon = "⚙", color = "#ff9e64" },
			},
			override_by_filename = {
				["CMakeLists.txt"] = { icon = "", color = "#5898d4" },
				["Kconfig"] = { icon = "⚙", color = "#326ce5" },
			},
		})

		-- local get_icon = devicons.get_icon
		-- ---@diagnostic disable-next-line: duplicate-set-field
		-- devicons.get_icon = function(name, ext, opts)
		-- 	if name:match("Kconfig") then
		-- 		return "⚙", "#326ce5"
		-- 	elseif name:match("defconfig") then
		-- 		return "", "#e67e22"
		-- 	end
		-- 	return get_icon(name, ext, opts)
		-- end
	end,
}

return {
	"thePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		-- local conf = require("telescope.config").values

		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon list files" })

		--Harpoon marked files
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1st file" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2nd file" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(4) end, { desc = "Harpoon 3rd file" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev file" })
		vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next file" })
	end,
}

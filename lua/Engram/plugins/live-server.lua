return {
	{
		"ngtuonghy/live-server-nvim",
		event = "VeryLazy",
		build = ":LiveServerInstall",
		config = function()
			require("live-server-nvim").setup({
				open = "folder", -- Opens the project root
				port = 8080,
			})

			-- Custom keymap for your workflow
			vim.keymap.set("n", "<leader>gl", ":LiveServerToggle<CR>", { desc = "Toggle Live Server" })
		end,
	},
}

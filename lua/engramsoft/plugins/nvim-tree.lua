return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- ADDED: local api + custom bulk-move function
		local api = require("nvim-tree.api")

		-- ADDED: move all marked files/dirs into a chosen directory
		local function move_marked_to_dir()
			local marks = api.marks.list()
			if not marks or #marks == 0 then
				vim.notify("No marked items. Mark with 'm' first.", vim.log.levels.WARN)
				return
			end

			-- prompt for target directory
			local dest = vim.fn.input("Move marked to directory: ", "", "dir")
			if dest == nil or dest == "" then
				return
			end

			-- normalize & ensure directory exists
			dest = vim.fn.fnamemodify(dest, ":p") -- absolute path
			vim.fn.mkdir(dest, "p") -- create dirs if needed

			local uv = vim.loop
			local moved = 0
			for _, node in ipairs(marks) do
				local src = node.absolute_path
				local target = dest .. "/" .. node.name

				-- try libuv rename; fallback to os.rename
				local ok, err = pcall(uv.fs_rename, src, target)
				if not ok then
					local ok2, err2 = os.rename(src, target)
					if not ok2 then
						vim.notify(
							"Failed to move: " .. src .. " -> " .. target .. "\n" .. tostring(err2 or err),
							vim.log.levels.ERROR
						)
					else
						moved = moved + 1
					end
				else
					moved = moved + 1
				end
			end

			api.tree.reload()
			api.marks.clear()
			vim.notify("Moved " .. moved .. " item(s) to " .. dest, vim.log.levels.INFO)
		end

		-- ADDED: nvim-tree buffer keymaps via on_attach
		local function on_attach(bufnr)
			-- keep default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- our custom bulk move on "mm"
			vim.keymap.set("n", "mm", move_marked_to_dir, {
				desc = "Move marked items to directory",
				buffer = bufnr,
				noremap = true,
				silent = true,
			})
		end

		nvimtree.setup({
			-- ADDED: wire up on_attach so "mm" works inside nvim-tree
			on_attach = on_attach,

			view = {
				width = 35,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
	end,
}

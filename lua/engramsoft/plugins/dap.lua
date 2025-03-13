return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"williamboman/mason.nvim",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup UI and Virtual Text
			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

			-- Mason integration for dap
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- Auto-open UI on debug events
			dap.listeners.after.event_initialized["dapui_config"] = function()
				require("dapui").open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				require("dapui").close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				require("dapui").close()
			end

			-- Rust debugging adapter configuration
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}

			-- Rust debugging launch configuration
			dap.configurations.rust = {
				{
					name = "Launch Rust program",
					type = "codelldb",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						local default_program = cwd .. "/target/debug/" .. vim.fn.fnamemodify(cwd, ":t")
						return vim.fn.input("Path to executable: ", default_program, "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- C++ debugging launch configuration
			dap.configurations.cpp = {
				{
					name = "Launch C++ program",
					type = "codelldb",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						local default_program = cwd .. "/build/" .. vim.fn.fnamemodify(cwd, ":t")
						return vim.fn.input("Path to executable: ", default_program, "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- C debugginh launch configuration
			dap.configurations.c = dap.configurations.cpp

			-- Recommended keybindings
			vim.keymap.set("n", "<Leader>dd", dap.continue, { desc = "Debug / Debug Continue" })
			vim.keymap.set("n", "<Leader>dn", dap.step_over, { desc = "Debug Step Over" })
			vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Debug Step Into" })
			vim.keymap.set("n", "<Leader>do", dap.step_out, { desc = "Debug Step Out" })
			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Debug Toggle Breakpoint" })
		end,
	},
}

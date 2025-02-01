return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.expand("$HOME/.local/share/nvim/mason/bin/codelldb"),
				args = { "--port", "${port}" },
			},
		}
		-- PERF:
		-- ===================================================
		-- Configurations
		-- ====================================================
		dap.configurations.cpp = {
			{
				name = "C++: Run file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
			{
				-- If you get an "Operation not permitted" error using this, try disabling YAMA:
				--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
				name = "C++: Attach to process",
				type = "codelldb", -- Adjust this to match your adapter name (`dap.adapters.<name>`)
				request = "attach",
				pid = require("dap.utils").pick_process,
				args = {},
			},
			{
				name = "C++: ROS Node",
				type = "codelldb",
				request = "launch",
				-- Might need to consider using vim.ui.input
				program = function()
					local pkgName = vim.fn.input("ROS Package: ", "")
					return vim.fn.input(
						"Path to executable: ",
						vim.fn.getcwd() .. "/install/" .. pkgName .. "/lib/" .. pkgName .. "/",
						"file"
					)
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		-- PERF:
		-- ====================================================
		-- Extensions configurations
		-- ====================================================
		require("dapui").setup({
			controls = {
				icons = {
					pause = "⏸ ",
					play = "▶ ",
					terminate = "⏹ ",
				},
			},
			floating = {
				border = "rounded",
			},
			layouts = {
				{
					elements = {
						{ id = "stacks",      size = 0.30 },
						{ id = "breakpoints", size = 0.20 },
						{ id = "scopes",      size = 0.50 },
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{ id = "console", size = 0.50 },
						{ id = "repl",    size = 0.50 },
					},
					position = "bottom",
					size = 10,
				},
			},
		})
		require("nvim-dap-virtual-text").setup()

		require("dap-python").setup()
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "ROS2 Launch",
				program = "/opt/ros/humble/bin/launch_test ",
				args = { "${file}" },
			},
			{
				name = "Select and attach to process",
				type = "codelldb",
				request = "attach",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				pid = function()
					local name = vim.fn.input('Executable name (filter): ')
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = '${workspaceFolder}'
			},
			{
				name = 'Attach to gdbserver :1234',
				type = 'codelldb',
				request = 'attach',
				target = 'localhost:1234',
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}'
			},
		}
		vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<Leader>dc", dap.continue, {})
	end,
}

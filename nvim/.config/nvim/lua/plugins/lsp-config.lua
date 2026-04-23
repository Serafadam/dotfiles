return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"neocmake",
					"dockerls",
					"jsonls",
					"marksman",
					"pyright",
					"lemminx",
					"yamlls",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            if capabilities.workspace then
              capabilities.workspace.didChangeWatchedFiles = nil
            end
            vim.lsp.config('*', {
              capabilities = capabilities,
            })
            vim.lsp.enable('clangd')
            vim.lsp.enable('neocmake')
            vim.lsp.enable('dockerls')
            vim.lsp.enable('jsonls')
            vim.lsp.enable('marksman')
            vim.lsp.enable('pyright')
            vim.lsp.enable('lemminx')
            vim.lsp.enable('yamlls')
			vim.lsp.config['clangd'] = {
				capabilities,
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--clang-tidy",
				},
			}

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", {})
		end,
	},
}

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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities,
			})
			lspconfig.clangd.setup({
				capabilities,
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--clang-tidy",
				},
			})
			lspconfig.neocmake.setup({
				capabilities,
			})
			lspconfig.dockerls.setup({
				capabilities,
			})
			lspconfig.jsonls.setup({
				capabilities,
			})
			lspconfig.marksman.setup({
				capabilities,
			})
			lspconfig.pyright.setup({
				capabilities,
			})
			lspconfig.lemminx.setup({
				capabilities,
			})
			lspconfig.yamlls.setup({
				capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", {})
		end,
	},
}

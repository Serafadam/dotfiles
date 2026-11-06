-- LSP setup for Neovim >= 0.11 (works on 0.12+).
--
-- Uses the built-in `vim.lsp.config()` / `vim.lsp.enable()` API instead of the
-- deprecated `require("lspconfig")[server].setup()` framework.
--
-- Why this matters for CMake: nvim-lspconfig still ships the old (deprecated)
-- config in `lua/lspconfig/configs/neocmake.lua`, which spawns
-- `neocmakelsp --stdio`. neocmakelsp >= 0.9 expects the subcommand `stdio`
-- (`neocmakelsp stdio`), so the legacy path starts a server that immediately
-- dies with "unexpected argument '--stdio' found" and CMake gets no LSP.
-- `vim.lsp.config`/`vim.lsp.enable` use the new `lsp/neocmake.lua` (correct cmd).
--
-- Requires: nvim >= 0.11, nvim-lspconfig >= 2.0, mason-lspconfig >= 2.0
return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"clangd",
				"neocmake",
				"dockerls",
				"jsonls",
				"marksman",
				"pyright",
				"lemminx",
				"yamlls",
				"zls",
				-- "rust_analyzer", -- handled by rustaceanvim
			},
			-- Do not auto-enable every installed server (that would also turn on
			-- basedpyright, taplo, gopls, ...). We enable an explicit list below.
			automatic_enable = false,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
		},
		config = function()
			---------------------------------------------------------------
			-- Capabilities (blink.cmp provides completion/snippet support)
			---------------------------------------------------------------
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_blink, blink = pcall(require, "blink.cmp")
			if has_blink then
				capabilities = blink.get_lsp_capabilities(capabilities)
			end
			-- neocmakelsp only offers completions when snippets are supported
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- Applied to every server; per-server configs (below or shipped in
			-- nvim-lspconfig's lsp/*.lua) are deep-merged on top of this.
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			---------------------------------------------------------------
			-- Keymaps: use LspAttach instead of on_attach.
			-- (A global `on_attach` via vim.lsp.config("*") would be *overridden*
			-- by server-provided on_attach functions, e.g. clangd's.)
			---------------------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local bufnr = ev.buf
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
					end

					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "<leader>gd", vim.lsp.buf.definition, "Definition")
					map("n", "<leader>gr", vim.lsp.buf.references, "References")
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

					-- clangd creates this buffer-local command on attach.
					-- (Renamed from the old global :ClangdSwitchSourceHeader)
					map("n", "<leader>sh", function()
						local cmds = vim.api.nvim_buf_get_commands(bufnr, {})
						if cmds.LspClangdSwitchSourceHeader then
							vim.cmd("LspClangdSwitchSourceHeader")
						else
							vim.notify("clangd is not attached to this buffer", vim.log.levels.WARN)
						end
					end, "Switch source/header")
				end,
			})

			---------------------------------------------------------------
			-- Server-specific overrides
			---------------------------------------------------------------
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--clang-tidy",
					"--offset-encoding=utf-16",
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			-- Default root markers are only `.neocmake.toml`, `.git`, `build`, `cmake`,
			-- so neocmake never attaches in a plain source tree. A CMakeLists.txt is
			-- a much better marker (and handles monorepos via the nearest one).
			vim.lsp.config("neocmake", {
				root_markers = { "CMakeLists.txt", "CMakePresets.json", ".neocmake.toml", ".git" },
			})

			---------------------------------------------------------------
			-- rust_analyzer override (used when rustaceanvim is disabled;
			-- rustaceanvim manages its own client, so we do not enable it here)
			---------------------------------------------------------------
			local cargo_home = os.getenv("CARGO_HOME")
			local rustup_home = os.getenv("RUSTUP_HOME")
			if cargo_home and rustup_home then
				local sysroot = vim.trim(vim.fn.system("rustc --print sysroot"))
				local rust_src = sysroot .. "/lib/rustlib/src/rust"

				vim.lsp.config("rust_analyzer", {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								targetDir = cargo_home .. "/target", -- was `target` (expects a triple)
								extraEnv = {
									CARGO_HOME = cargo_home,
									RUSTUP_HOME = rustup_home,
								},
							},
							env = {
								CARGO_HOME = cargo_home,
								RUSTUP_HOME = rustup_home,
								PATH = os.getenv("PATH"),
							},
						},
					},
					env = {
						CARGO_HOME = cargo_home,
						RUSTUP_HOME = rustup_home,
						PATH = os.getenv("PATH"),
					},
				})

				-- Only point rust-analyzer at the std sources if they exist.
				if vim.uv.fs_stat(rust_src) then
					vim.lsp.config("rust_analyzer", {
						settings = { ["rust-analyzer"] = { rustc = { source = rust_src } } },
					})
				end
			end

			---------------------------------------------------------------
			-- Enable the servers (auto-activation on matching filetypes)
			---------------------------------------------------------------
			local servers = {
				"lua_ls",
				"bashls",
				"clangd",
				"neocmake",
				"dockerls",
				"jsonls",
				"marksman",
				"pyright",
				"lemminx",
				"yamlls",
				"zls",
				"ruff", -- installed by mason; harmless if missing
				-- "rust_analyzer", -- rustaceanvim handles Rust
			}

			local enable = {}
			for _, name in ipairs(servers) do
				local cfg = vim.lsp.config[name]
				local cmd = cfg and cfg.cmd
				if type(cmd) == "table" then
					cmd = cmd[1]
				end
				-- Skip servers whose executable is not installed yet
				-- (mason may still be installing them on first launch).
				if type(cmd) ~= "string" or vim.fn.executable(cmd) == 1 then
					enable[#enable + 1] = name
				end
			end
			vim.lsp.enable(enable)
		end,
	},
}

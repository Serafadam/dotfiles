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
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            -- Common configuration for all servers
            local on_attach = function(client, bufnr)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { buffer = bufnr })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
                vim.keymap.set("n", "<leader>sh", ":ClangdSwitchSourceHeader<CR>", { buffer = bufnr })
            end

            -- Server-specific configurations
            local servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--offset-encoding=utf-16",
                        "--clang-tidy",
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                neocmake = {},
                dockerls = {},
                jsonls = {},
                marksman = {},
                pyright = {},
                lemminx = {},
                yamlls = {},
                ruff = {}
            }
            vim.lsp.config('ruff', {
                init_options = {
                    settings = {
                        -- Ruff language server settings go here
                    }
                }
            })

            vim.lsp.enable('ruff')

            -- Setup all servers
            for server_name, config in pairs(servers) do
                lspconfig[server_name].setup(vim.tbl_extend("force", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }, config))
            end
        end,
    },
}

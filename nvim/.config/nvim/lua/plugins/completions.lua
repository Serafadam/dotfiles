return {
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "github/copilot.vim"
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {},
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    -- { name = "vsnip" }, -- For vsnip users.
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
                require("cmp").setup({
                    formatting = {
                        format = function(entry, vim_item)
                            local highlights_info = require("colorful-menu").cmp_highlights(entry)

                            -- highlight_info is nil means we are missing the ts parser, it's
                            -- better to fallback to use default `vim_item.abbr`. What this plugin
                            -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                            if highlights_info ~= nil then
                                vim_item.abbr = highlights_info.text
                            end

                            return vim_item
                        end,
                    },
                })
            })
        end,
    },
}

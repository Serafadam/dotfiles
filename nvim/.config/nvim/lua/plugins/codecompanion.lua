return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup {
            adapters = {
                mistral = function()
                    return require("codecompanion.adapters").extend("mistral", {
                        env = {
                            api_key = "CODESTRAL_API_KEY",
                            url = "https://codestral.mistral.ai"
                        },
                        schema = {
                            model = {
                                default = "codestral-latest"
                            }
                        }
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = "mistral",
                },
                inline = {
                    adapter = "mistral",
                },
            },
        }
    end
}


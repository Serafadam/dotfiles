return {
    "tris203/precognition.nvim",
    config = function()
        local precog = require("precognition")
        precog.setup({
            targetedMotionHints = {
                enabled = false,
                prio = 1,
            },
        })
    end,
}

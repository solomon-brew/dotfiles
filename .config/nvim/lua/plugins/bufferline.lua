local bufferline = require("bufferline")
return {
    "akinsho/bufferline.nvim",
    opts = {
        -- local bufferline - require('bufferline')
        -- bufferline
        options = {
            style_preset = bufferline.style_preset.minimal, -- or bufferline.style_preset.minimal,
            separator_style = { "", "" },
            hover = {
                enabled = true,
                delay = 200,
                reveal = { "close" },
            },
            indicator = {
                style = "underline",
            },
            --     offsets = {
            --       {
            --         text_align = "right",
            --       },
            --     },
            tab_size = 12,
        },
    },
}

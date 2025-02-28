return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
        local ibl = require("ibl")
        ibl.setup({
            scope = {
                show_start = false,
                show_end = false,
            },
            indent = {
                char = "▎"
            }
        })
    end
}


-- local highlight = {
--     "RainbowRed",
--     "RainbowYellow",
--     "RainbowBlue",
--     "RainbowOrange",
--     "RainbowGreen",
--     "RainbowViolet",
--     "RainbowCyan",
-- }

-- local monokai_pro_colors = {
--     red = "#FF6188",
--     yellow = "#FFD866",
--     blue = "#78DCE8",
--     orange = "#FFB366",
--     green = "#A9DC76",
--     violet = "#AB9DF2",
--     cyan = "#78DCE8",
-- }
-- local hooks = require "ibl.hooks"
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--     vim.api.nvim_set_hl(0, "RainbowRed", { fg = monokai_pro_colors.red })
--     vim.api.nvim_set_hl(0, "RainbowYellow", { fg = monokai_pro_colors.yellow })
--     vim.api.nvim_set_hl(0, "RainbowBlue", { fg = monokai_pro_colors.blue })
--     vim.api.nvim_set_hl(0, "RainbowOrange", { fg = monokai_pro_colors.orange })
--     vim.api.nvim_set_hl(0, "RainbowGreen", { fg = monokai_pro_colors.green })
--     vim.api.nvim_set_hl(0, "RainbowViolet", { fg = monokai_pro_colors.violet })
--     vim.api.nvim_set_hl(0, "RainbowCyan", { fg = monokai_pro_colors.cyan })
-- end)

-- vim.g.rainbow_delimiters = { highlight = highlight }
-- require("ibl").setup { scope = { highlight = highlight } }

-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
